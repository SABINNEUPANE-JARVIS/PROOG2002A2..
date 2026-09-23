var express = require('express');
var app = express();
// Adds the CORS header manually instead of using the cors package.
// Keeps the code simple and uses only Express.
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Content-Type");
    next();
});
var charityAPI = require("./controllerAPI/api-controller");
app.use("/api/events", charityAPI);

app.listen(3060);
console.log("Charity Events API is running on port 3060");