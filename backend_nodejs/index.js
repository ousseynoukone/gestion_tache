var express = require('express');
let app = express();

// link : https://deeppatel23.medium.com/rest-api-with-node-js-and-firebase-4d618f1bbc60

const { getTasks, deleteTask } = require("./endpoints/tasks");


const PORT = process.env.PORT || 5050;


app.get("/api/v1/tasks", getTasks);

app.delete("/api/v1/taskDelete/id",deleteTask);


// make the request to delete 


// make the request to update 



app.get('/', (req, res) => {
    res.send('This is my demo project')
})




app.listen(PORT, function () { console.log(`Demo project at: ${PORT}!`); });