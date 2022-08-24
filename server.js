var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var mysql = require('mysql');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));

// default route
app.get('/', function (req, res) {
    return res.send({ error: true, message: 'API of WES POC' })
});
// connection configurations
var dbConn = mysql.createConnection({
    host: 'localhost',
    user: 'wes_user',
    password: 'delaPlex@123',
    database: 'kpi_wes'
});
// connect to database
dbConn.connect(); 

// Retrieve all storage location 
app.get('/storageLocations', function (req, res) {
    dbConn.query('SELECT * FROM storage_locations', function (error, results, fields) {
    if (error) throw results;
        return res.send({ error: false, data: results, message: 'List of storage locations.' });
    });
});

// Retrieve all steps 
app.get('/steps', function (req, res) {
    dbConn.query('SELECT * FROM steps', function (error, results, fields) {
    if (error) throw results;
        return res.send({ error: false, data: results, message: 'List of steps.' });
    });
});

// Retrieve step with id 
app.get('/steps/:id', function (req, res) {
    let id = req.params.id;
    if (!id) {
        return res.status(400).send({ error: true, message: 'Please provide step id' });
    }

    dbConn.query('SELECT * FROM steps where id=?', id, function (error, results, fields) {
    if (error) throw error;
        return res.send({ error: false, data: results[0], message:  results[0] ? 'Steps details' : 'No step found'});
    });
});

// Retrieve all workflows 
app.get('/workflows', function (req, res) {
    dbConn.query(`SELECT wf.ID, wf.Name, sl.Name as StorageLocationName, sl.BuildingNo, sl.BlockNo 
    FROM workflows as wf
    LEFT JOIN storage_locations as sl ON wf.StorageLocationID = sl.ID`, function (error, results, fields) {
    if (error) throw results;
        return res.send({ error: false, data: results, message: 'List of workflows.' });
    });
});

// Retrieve workflow details with id 
app.get('/workflows/:id', function (req, res) {
    let id = req.params.id;
    if (!id) {
        return res.status(400).send({ error: true, message: 'Please provide workflow id' });
    }

    dbConn.query(`SELECT wf.ID, wf.Name, sl.Name as StorageLocationName, sl.BuildingNo, sl.BlockNo 
                FROM workflows as wf
                LEFT JOIN storage_locations as sl ON wf.StorageLocationID = sl.ID
                where wf.ID =?`, id, function (error, results, fields) {
            if (results) {
                dbConn.query(`SELECT flows.ID as FlowID, flows.Name as FlowName, flows.StrategyName 
                    FROM workflow_flows
                    LEFT JOIN flows ON workflow_flows.FlowID = flows.ID
                    WHERE workflow_flows.WorkflowID=?`, id, function (error, res1, fields) {
                    if (res1) {
                        results[0]['WorkflowFlows'] = res1;
                        return res.send({ error: false, data: results[0], message:  results[0] ? 'Workflow details' : 'No workflow found'});
                    }
                });
            } else {
                return res.send({ error: false, data: results[0], message:  results[0] ? 'Workflow details' : 'No workflow found'});
            }
        
    });
});

// Add a new workflow  
app.post('/workflow', function (req, res) {
    let workflow = req.body.workflow;
    if (!workflow) {
        return res.status(400).send({ error:true, message: 'Please provide workflow' });
    }
    dbConn.query("INSERT INTO workflows SET ? ", { workflow: workflow }, function (error, results, fields) {
    if (error) throw error;
        return res.send({ error: false, data: results, message: 'New workflow has been created successfully.' });
    });
});

// Retrieve all orders 
app.get('/orders', function (req, res) {
    dbConn.query('SELECT * FROM orders', function (error, results, fields) {
    if (error) throw results;
        return res.send({ error: false, data: results, message: 'List of orders.' });
    });
});

// Retrieve order with id 
app.get('/orders/:id', function (req, res) {
    let id = req.params.id;
    if (!id) {
        return res.status(400).send({ error: true, message: 'Please provide order id' });
    }

    dbConn.query('SELECT * FROM orders where id=?', id, function (error, results, fields) {
    if (error) throw error;
        return res.send({ error: false, data: results[0], message:  results[0] ? 'Order details' : 'No order found'});
    });
});

// Retrieve all orderWorkflow 
app.get('/orderWorkflow', function (req, res) {
    dbConn.query('SELECT * FROM order_workflow', function (error, results, fields) {
    if (error) throw results;
        return res.send({ error: false, data: results, message: 'List of order workflow.' });
    });
});

// Retrieve orderWorkflow with id 
app.get('/orderWorkflow/:id', function (req, res) {
    let id = req.params.id;
    if (!id) {
        return res.status(400).send({ error: true, message: 'Please provide order workflow id' });
    }

    dbConn.query('SELECT * FROM order_workflow where id=?', id, function (error, results, fields) {
    if (error) throw error;
        return res.send({ error: false, data: results[0], message:  results[0] ? 'Order workflow details' : 'No order workflow found'});
    });
});

// Retrieve all flows 
app.get('/flows', function (req, res) {
    dbConn.query('SELECT * FROM flows', function (error, results, fields) {
    if (error) throw results;
        return res.send({ error: false, data: results, message: 'List of flows.' });
    });
});

// Retrieve flow with id 
app.get('/flows/:id', function (req, res) {
    let id = req.params.id;
    if (!id) {
        return res.status(400).send({ error: true, message: 'Please provide flow id' });
    }

    dbConn.query(`SELECT * FROM flows where id=?`, id, function (error, results, fields) {
        if (error) return 'SQL Error: No flow found. Error:'+ error;
        if (results) {
            dbConn.query(`SELECT steps.ID as StepID, steps.Name as StepName 
                FROM flow_steps
                LEFT JOIN steps ON flow_steps.StepID = steps.ID
                WHERE flow_steps.FlowID=?`, id, function (error, res1, fields) {
                if (res1) {
                    results[0]['flowSteps'] = res1;
                    return res.send({ error: false, data: results[0], message:  results[0] ? 'Flow details' : 'No flow found'});
                }
            });
        } else {
            return res.send({ error: false, data: results[0], message:  results[0] ? 'Flow details' : 'No flow found'});
        }
    });
});

// Retrieve flow Steps with id 
app.get('/flowSteps/:id', function (req, res) {
    let id = req.params.id;
    if (!id) {
        return res.status(400).send({ error: true, message: 'Please provide flow id' });
    }

    dbConn.query(`SELECT steps.ID as StepID, steps.Name as StepName 
    FROM flow_steps
    LEFT JOIN steps ON flow_steps.StepID = steps.ID
    WHERE flow_steps.FlowID=?`, id, function (error, results, fields) {
    if (error) throw error;
        return res.send({ error: false, data: results, message:  results? 'Flow details' : 'No flow found'});
    });
});

// Retrieve order workflow with order id 
app.get('/orderWorkflows/:id', function (req, res) {
    let orderID = req.params.id;
    if (!orderID) {
        return res.status(400).send({ error: true, message: 'Please provide workflow id' });
    }

    dbConn.query(`SELECT ow.ID, ow.Status, wf.Name as WorkflowName, wf.StorageLocationID, od.CustomerName, od.CustomerAddress, od.OrderDateTime, od.ShippingDate, od.status as OrderStatus, od.InventoryID 
        FROM order_workflow as ow
        LEFT JOIN orders as od ON ow.OrderID = od.ID
        LEFT JOIN workflows as wf ON ow.WorkflowID = wf.ID
        WHERE ow.ID = ?`, orderID, function (error, results, fields) {
    if (error) throw error;
        return res.send({ error: false, data: results[0], message:  results[0] ? 'Order Workflow details' : 'No order workflow found'});
    });
});

app.listen(3000, function () {
    console.log('API app is running on port 3000');
});
module.exports = app;