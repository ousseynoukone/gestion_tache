var express = require('express');
var app = express();

const { getTasks } = require("./endpoints/tasks");

const PORT = process.env.PORT || 5050;


app.get("/api/v1/tasks", getTasks);


// make the request to delete 


// make the request to update 



app.get('/', (req, res) => {
    res.send('This is my demo project')
})




app.listen(PORT, function () {
console.log(`Demo project at: ${PORT}!`); });