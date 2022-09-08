var express = require("express");
var app = express();
var bodyParser = require("body-parser");
var mysql = require("mysql");
const Promise = require("promise");
const _ = require("lodash");

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
var cors = require("cors");
app.use(cors());

// default route
app.get("/", function (req, res) {
  return res.send({ error: true, message: "API of WES POC" });
});
// connection configurations
var dbConn = mysql.createConnection({
  host: "localhost",
  user: "wes_user",
  password: "delaplex@123",
  database: "kpi_wes2",
});
// connect to database
dbConn.connect();

// Retrieve all storage location
app.get("/storageLocations", function (req, res) {
  dbConn.query(
    "SELECT * FROM storage_locations",
    function (error, results, fields) {
      if (error) throw results;
      return res.send({
        error: false,
        data: results,
        message: "List of storage locations.",
      });
    }
  );
});

// Get all Inventory
app.get("/inventory", function (req, res) {
  dbConn.query(
    "SELECT a.*, B.Name FROM inventory a INNER JOIN items B ON A.ItemID = B.ID ORDER BY a.ID",
    function (error, results, fields) {
      if (error) throw results;
      return res.send({
        error: false,
        data: results,
        message: "List of inventory.",
      });
    }
  );
});

// Retrieve all steps
app.get("/steps", function (req, res) {
  dbConn.query("SELECT * FROM steps", function (error, results, fields) {
    if (error) throw results;
    return res.send({ error: false, data: results, message: "List of steps." });
  });
});

// Retrieve step with id
app.get("/steps/:id", function (req, res) {
  let id = req.params.id;
  if (!id) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide step id" });
  }

  dbConn.query(
    "SELECT * FROM steps where id=?",
    id,
    function (error, results, fields) {
      if (error) throw error;
      return res.send({
        error: false,
        data: results[0],
        message: results[0] ? "Steps details" : "No step found",
      });
    }
  );
});

// Add a new steps
app.post("/steps", function (req, res) {
  let step = req.body;

  if (!step) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide step" });
  }

  dbConn.query(
    "INSERT INTO steps SET ? ",
    {
      Name: step.name,
      Type: step.type,
      HardwareID: step.hardwareId === "" ? 0 : step.hardwareId,
      Setting1: step.setting1,
      Setting2: step.setting2,
    },
    function (error, results, fields) {
      if (error) throw error;
      return res.send({
        error: false,
        message: "New step has been created successfully.",
      });
    }
  );
});

// Retrieve all workflows
app.get("/workflows", function (req, res) {
  dbConn.query(
    `SELECT wf.ID, wf.Name, sl.Name as StorageLocationName, sl.BuildingNo, sl.BlockNo 
    FROM workflows as wf
    LEFT JOIN storage_locations as sl ON wf.StorageLocationID = sl.ID
    WHERE wf.ID <> 11 `,
    function (error, results, fields) {
      if (error) throw results;
      return res.send({
        error: false,
        data: results,
        message: "List of workflows.",
      });
    }
  );
});

// Retrieve workflow details with id
app.get("/workflows/:id", function (req, res) {
  let id = req.params.id;
  if (!id) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide workflow id" });
  }

  dbConn.query(
    `SELECT wf.ID, wf.Name, sl.Name as StorageLocationName, sl.BuildingNo, sl.BlockNo, sl.ID as StorageLocationID 
                FROM workflows as wf
                LEFT JOIN storage_locations as sl ON wf.StorageLocationID = sl.ID
                where wf.ID =?`,
    id,
    function (error, results, fields) {
      if (results) {
        dbConn.query(
          `SELECT flows.ID as FlowID, flows.Name as FlowName, flows.StrategyName, workflow_flows.FlowOrder, flows.FlowType
                    FROM workflow_flows
                    LEFT JOIN flows ON workflow_flows.FlowID = flows.ID
                    WHERE workflow_flows.WorkflowID=? ORDER BY workflow_flows.FlowOrder`,
          id,
          function (error, res1, fields) {
            if (res1) {
              results[0]["WorkflowFlows"] = res1;

              for (let index = 0; index < res1.length; index++) {
                const flow = res1[index];
                dbConn.query(
                  `SELECT steps.ID as StepID, steps.Name as StepName, flow_steps.StepOrder
                        FROM flow_steps
                        LEFT JOIN steps ON flow_steps.StepID = steps.ID
                        WHERE flow_steps.FlowID= ${flow.FlowID} ORDER BY flow_steps.StepOrder`,
                  function (error, res_flow, fields) {
                    if (res_flow) {
                      results[0]["WorkflowFlows"][index]["flowSteps"] =
                        res_flow;
                      if (index == res1.length - 1) {
                        return res.send({
                          error: false,
                          data: results[0],
                          message: results[0]
                            ? "Workflow details"
                            : "No workflow found",
                        });
                      }
                    }
                  }
                );
              }
            }
          }
        );
      } else {
        return res.send({
          error: false,
          data: results[0],
          message: results[0] ? "Workflow details" : "No workflow found",
        });
      }
    }
  );
});

// Add a new workflow
app.post("/workflow", function (req, res) {
  let workflow = req.body;

  if (!workflow) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide workflow" });
  }

  dbConn.query(
    "INSERT INTO workflows SET ? ",
    { Name: workflow.name, StorageLocationID: 0 },
    function (error, results, fields) {
      if (error) throw error;
      workflow.workflowFlows.forEach((workflowFlow) => {
        dbConn.query(
          "INSERT INTO workflow_flows SET ? ",
          {
            WorkflowID: results.insertId,
            FlowID: workflowFlow.flowID,
            FlowOrder: workflowFlow.flowOrder,
          },
          function (error, results, fields) {
            if (error) throw error;
            console.log(results);
          }
        );
      });
      return res.send({
        error: false,
        message: "New workflow has been created successfully.",
      });
    }
  );
});

// Retrieve all orders
app.get("/orders", function (req, res) {
  dbConn.query(
    "SELECT a.* , b.Name as WorkflowName FROM orders a INNER JOIN workflows b ON a.WorkflowID = b.ID ORDER BY ID DESC",
    function (error, results, fields) {
      if (error) throw results;
      return res.send({
        error: false,
        data: results,
        message: "List of orders.",
      });
    }
  );
});

// Retrieve order with id
app.get("/orders/:id", function (req, res) {
  let id = req.params.id;
  if (!id) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide order id" });
  }

  dbConn.query(
    "SELECT * FROM orders where id=?",
    id,
    function (error, results, fields) {
      if (error) throw error;
      return res.send({
        error: false,
        data: results[0],
        message: results[0] ? "Order details" : "No order found",
      });
    }
  );
});

// Add a new order
app.post("/order", function (req, res) {
  let order = req.body;

  if (!order) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide order" });
  }

  dbConn.query(
    "SELECT HardwareID FROM inventory WHERE id=?",
    order.InventoryID,
    function (error, iresults, fields) {
      console.log("iresults", iresults);
      if (error) throw error;
      dbConn.query(
        "SELECT ID FROM flows WHERE FlowType=? LIMIT 1",
        order.OrderType,
        function (error, fresults, fields) {
          console.log("fresults", fresults);
          if (error) throw error;
          dbConn.query(
            `SELECT b.FlowID,c.FlowType FROM steps a inner join flow_steps b ON a.ID = b.StepID 
            inner join flows c on b.FlowID = c.ID
            WHERE b.FlowId = ${fresults[0].ID} and a.HardwareID = ${iresults[0].HardwareID} ORDER BY b.StepOrder LIMIT 1`,
            [],
            function (error, flresults, fields) {
              console.log("flresults", flresults);
              if (error) throw error;
              let sql = "";

              if (flresults[0].FlowType === "HSLP") {
                sql = `SELECT a.WorkflowID FROM workflow_flows a inner join workflows b on a.WorkflowID = b.ID 
                where a.FlowID = ${flresults[0].FlowID} AND b.FlowType = '${flresults[0].FlowType}'
                order by a.FlowOrder Limit 1`;
              } else {
                sql = `SELECT a.WorkflowID FROM workflow_flows a inner join workflows b on a.WorkflowID = b.ID where a.FlowID = ${flresults[0].FlowID}  
                order by a.FlowOrder Limit 1`;
              }

              dbConn.query(sql, [], function (error, wflresults, fields) {
                console.log("wflresults", wflresults);
                // return;
                if (error) throw error;
                dbConn.query(
                  "INSERT INTO orders SET ? ",
                  {
                    OrderType: order.OrderType,
                    OrderDateTime: order.OrderDateTime,
                    InventoryID: order.InventoryID,
                    WorkflowID: wflresults[0].WorkflowID,
                    Quantity: order.Quantity,
                  },
                  function (error, oresults, fields) {
                    if (error) throw error;
                    dbConn.query(
                      "INSERT INTO order_workflow_flow SET ? ",
                      {
                        OrderID: oresults.insertId,
                        WorkflowFlowID: wflresults[0].WorkflowID,
                        status: 1,
                      },
                      function (error, owflresults, fields) {
                        if (error) throw error;
                        getWorkflow_Flow(
                          owflresults.insertId,
                          wflresults[0].WorkflowID,
                          function (data) {
                            return res.send({
                              error: false,
                              message:
                                "New order has been created successfully.",
                            });
                          }
                        );
                      }
                    );
                  }
                );
              });
            }
          );
        }
      );
    }
  );
});

function getWorkflow_Flow(OrderWorkflowFlowID, WorkflowFlowID, callback) {
  dbConn.query(
    "SELECT FlowID, FlowOrder FROM workflow_flows WHERE WorkflowID = ? ORDER BY FlowOrder",
    WorkflowFlowID,
    function (error, FlowResults, fields) {
      if (error) throw error;
      if (FlowResults.length == 0) {
        return callback({ status: "success" });
      } else {
        let i = 0;
        let nextPromise = function () {
          if (i >= FlowResults.length) {
            return callback({ status: "success" });
          } else {
            getFlowSteps(
              FlowResults[i].FlowID,
              WorkflowFlowID,
              OrderWorkflowFlowID,
              i,
              function (fData) {
                i++;
                let newPromise = Promise.resolve(FlowResults, i);
                return newPromise.then(nextPromise);
              }
            );
          }
        };
        return Promise.resolve().then(nextPromise);
      }
    }
  );
}

function getFlowSteps(
  FlowID,
  WorkflowFlowID,
  OrderWorkflowFlowID,
  i,
  callback
) {
  dbConn.query(
    "SELECT StepID, StepOrder FROM flow_steps WHERE FlowID = ? ORDER BY StepOrder",
    FlowID,
    function (error, StepResults, fields) {
      if (error) throw error;
      if (StepResults.length == 0) {
        return callback({ status: "success" });
      } else {
        let j = 0;
        let nextPromiseStep = function () {
          if (j >= StepResults.length) {
            return callback({ status: "success" });
          } else {
            insertWorkflow_Flow_Steps(
              StepResults[j].StepID,
              FlowID,
              WorkflowFlowID,
              OrderWorkflowFlowID,
              i,
              j,
              function (sData) {
                j++;
                let newPromiseStep = Promise.resolve(StepResults, j);
                return newPromiseStep.then(nextPromiseStep);
              }
            );
          }
        };
        return Promise.resolve().then(nextPromiseStep);
      }
    }
  );
}

function insertWorkflow_Flow_Steps(
  StepID,
  FlowID,
  WorkflowFlowID,
  OrderWorkflowFlowID,
  i,
  j,
  callback
) {
  let status = "To-Do";
  if (i == 0 && j == 0) {
    status = "In-Progress";
  }
  dbConn.query(
    "INSERT INTO order_workflow_flow_steps SET ? ",
    {
      OrderWorkflowFlowID: OrderWorkflowFlowID,
      workflowID: WorkflowFlowID,
      flowId: FlowID,
      stepId: StepID,
      step_status: status,
    },
    function (error, eresults, fields) {
      if (error) throw error;
      return callback({ status: "success" });
    }
  );
}

// Retrieve all flows
app.get("/flows", function (req, res) {
  dbConn.query("SELECT * FROM flows", function (error, results, fields) {
    if (error) throw results;
    return res.send({ error: false, data: results, message: "List of flows." });
  });
});

// Retrieve flow with id
app.get("/flows/:id", function (req, res) {
  let id = req.params.id;
  if (!id) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide flow id" });
  }

  dbConn.query(
    `SELECT * FROM flows where id=?`,
    id,
    function (error, results, fields) {
      if (error) return "SQL Error: No flow found. Error:" + error;
      if (results) {
        dbConn.query(
          `SELECT steps.ID as StepID, steps.Name as StepName
                FROM flow_steps
                LEFT JOIN steps ON flow_steps.StepID = steps.ID
                WHERE flow_steps.FlowID=?`,
          id,
          function (error, res1, fields) {
            if (res1) {
              results[0]["flowSteps"] = res1;
              return res.send({
                error: false,
                data: results[0],
                message: results[0] ? "Flow details" : "No flow found",
              });
            }
          }
        );
      } else {
        return res.send({
          error: false,
          data: results[0],
          message: results[0] ? "Flow details" : "No flow found",
        });
      }
    }
  );
});

// Add a new flow
app.post("/flow", function (req, res) {
  let flow = req.body;

  if (!flow) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide flow" });
  }

  dbConn.query(
    "INSERT INTO flows SET ? ",
    {
      Name: flow.name,
      StrategyName: flow.strategyName,
      FlowType: flow.flowType,
    },
    function (error, results, fields) {
      if (error) throw error;
      flow.flowSteps.forEach((step) => {
        dbConn.query(
          "INSERT INTO flow_steps SET ? ",
          {
            FlowID: results.insertId,
            StepID: step.stepId,
            StepOrder: step.stepOrder,
          },
          function (error, results, fields) {
            if (error) throw error;
            console.log(results);
          }
        );
      });
      return res.send({
        error: false,
        message: "New flow has been created successfully.",
      });
    }
  );
});

// Retrieve flow Steps with id
app.get("/flowSteps/:id", function (req, res) {
  let id = req.params.id;
  if (!id) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide flow id" });
  }

  dbConn.query(
    `SELECT steps.ID as StepID, steps.Name as StepName , steps.Setting1, steps.Setting2
      FROM flow_steps
      LEFT JOIN steps ON flow_steps.StepID = steps.ID
      WHERE flow_steps.FlowID=?`,
    id,
    function (error, results, fields) {
      if (error) throw error;
      return res.send({
        error: false,
        data: results,
        message: results ? "Flow details" : "No flow found",
      });
    }
  );
});

// Retrieve order workflow with order id
// app.get("/orderWorkflows/:id", function (req, res) {
//   let orderID = req.params.id;
//   if (!orderID) {
//     return res
//       .status(400)
//       .send({ error: true, message: "Please provide workflow id" });
//   }

//   dbConn.query(
//     `SELECT ow.ID, ow.Status, wf.Name as WorkflowName, wf.StorageLocationID, od.CustomerName, od.CustomerAddress, od.OrderDateTime, od.ShippingDate, od.status as OrderStatus, od.InventoryID
//         FROM order_workflow as ow
//         LEFT JOIN orders as od ON ow.OrderID = od.ID
//         LEFT JOIN workflows as wf ON ow.WorkflowID = wf.ID
//         WHERE ow.ID = ?`,
//     orderID,
//     function (error, results, fields) {
//       if (error) throw error;
//       return res.send({
//         error: false,
//         data: results[0],
//         message: results[0]
//           ? "Order Workflow details"
//           : "No order workflow found",
//       });
//     }
//   );
// });

// Retrieve all hardwares
app.get("/hardwares", function (req, res) {
  dbConn.query("SELECT * FROM hardware", function (error, results, fields) {
    if (error) throw results;
    return res.send({ error: false, data: results, message: "List of items." });
  });
});

// Add a new step
app.post("/step", function (req, res) {
  let step = req.body;

  if (!step) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide step" });
  }

  dbConn.query(
    "INSERT INTO steps SET ? ",
    {
      Name: step.Name,
      Type: step.Type,
      HardwareID: step.HardwareID === "" ? 0 : step.HardwareID,
      Setting1: step.Setting1,
      Setting2: step.Setting2,
    },
    function (error, results, fields) {
      if (error) throw error;
      return res.send({
        error: false,
        message: "New step has been created successfully.",
      });
    }
  );
});

// Retrieve order workflow details with order id
app.get("/orderWorkflows/:id", function (req, res) {
  let id = req.params.id;
  if (!id) {
    return res
      .status(400)
      .send({ error: true, message: "Please provide workflow id" });
  }

  dbConn.query(
    `SELECT ID, WorkflowFlowID FROM order_workflow_flow WHERE OrderID =?`,
    id,
    function (error, oresults, fields) {
      let workFlowId = oresults[0].WorkflowFlowID;
      let orderWorkFlowId = oresults[0].ID;
      dbConn.query(
        `SELECT wf.ID, wf.Name FROM workflows as wf WHERE wf.ID =?`,
        workFlowId,
        function (error, results, fields) {
          dbConn.query(
            `SELECT distinct flows.ID as FlowID, flows.Name as FlowName, flows.StrategyName, workflow_flows.FlowOrder FROM workflow_flows LEFT JOIN order_workflow_flow_steps ON workflow_flows.WorkflowID = order_workflow_flow_steps.workflowID LEFT JOIN flows ON workflow_flows.FlowID = flows.ID WHERE order_workflow_flow_steps.workflowID = ${workFlowId} and order_workflow_flow_steps.OrderWorkflowFlowID = ${orderWorkFlowId}`,
            [],
            function (error, res1, fields) {
              if (res1) {
                let flowIdArr = _.map(res1, "FlowID");
                results[0]["Workflow_Flows"] = res1;
                dbConn.query(
                  `SELECT distinct steps.ID as StepID, steps.Name as StepName,  order_workflow_flow_steps.flowID, order_workflow_flow_steps.step_status FROM order_workflow_flow_steps LEFT JOIN steps ON order_workflow_flow_steps.stepID = steps.ID WHERE order_workflow_flow_steps.workflowID = ${workFlowId} and order_workflow_flow_steps.flowID IN (${flowIdArr}) and order_workflow_flow_steps.OrderWorkflowFlowID = ${orderWorkFlowId} Order By order_workflow_flow_steps.ID`,
                  [],
                  function (error, res2, fields) {
                    let flowIdArr = [];
                    for (let i = 0; i < res1.length; i++) {
                      let splitArr = [];
                      let flowArr = _.filter(res1, { FlowID: res1[i].FlowID });
                      if (flowArr.length > 1) {
                        for (let j = 0; j < res2.length; j++) {
                          if (res2[j].flowID === res1[i].FlowID) {
                            splitArr.push(i);
                            flowIdArr.push(res1[i].FlowID);
                          }
                        }
                      }
                      splitArr = _.uniq(splitArr);
                      // console.log("splitArr", splitArr);
                      // let count = flowIdArr.filter(x => x == res1[i].FlowID).length;
                      let stepArr = _.filter(res2, { flowID: res1[i].FlowID });
                      let index = _.findIndex(results[0].Workflow_Flows, {
                        FlowID: res1[i].FlowID,
                      });
                      // console.log("count", count);
                      if (flowIdArr.includes(res1[i].FlowID)) {
                        // cnt = +(count -1);
                        // console.log("cnt", splitArr);
                        results[0].Workflow_Flows[splitArr[0]]["flowSteps"] =
                          stepArr;
                      } else {
                        results[0].Workflow_Flows[index]["flowSteps"] = stepArr;
                      }
                      if (i == res1.length - 1) {
                        return res.send({
                          error: false,
                          data: results[0],
                          message: results[0]
                            ? "Workflow details"
                            : "No workflow found",
                        });
                      }
                    }
                  }
                );
              }
            }
          );
        }
      );
    }
  );
});

app.listen(3000, function () {
  console.log("API app is running on port 3000");
});
module.exports = app;
