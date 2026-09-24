//Clientside server for the charity events website.
const express = require("express");
const path = require("path");

const app = express();

//Serve files only from the public folder.
//Fix the security issue by using express.static .
app.use(express.static(path.join(__dirname, "public")));
//route to serve index.html
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "public", "index.html"));
});
//route to serve search.html
app.get("/search", (req, res) => {
    res.sendFile(path.join(__dirname, "public", "search.html"));
}); 
//route to serve event.html
app.get("/event", (req, res) => {
    res.sendFile(path.join(__dirname, "public", "event.html"));
});
// Start the server on port 8080. Keep this running while the API
// runs in another terminal on port 3060.
app.listen(8080, () => {
    console.log("Running in 8080");
});

