//Defines the RESTful API endpoints for the charity events website.
//Each route runs a MYSQL query and sends the result back as JSON.
var dbcon =  require("../database");
var connection = dbcon.getconnection();
//Test the connection on startup with an error callback.
//If the password or server is wrong, this logs a clear error instead of failing silently later.
connection.getConnection((err, conn) => {
    if (err) {
        console.error("Database connection failed: " + err.message);
        throw err;
    }
    console.log("Connected to charityevents_db!");
    conn.release();// hand the connection back to the pool
});
var express = require('express');
var router = express.Router();
/* ---------- GET /api/events ----------
   Home page: returns active + upcoming events (suspended excluded) */
router.get("/", (req, res) => {
    var sql = "SELECT e.event_id, e.event_name, e.event_date, e.location, " + 
              "e.ticket_price, e.image_url, c.category_name, " + 
              "CASE WHEN e.event_date >= NOW() THEN 'Upcoming' ELSE 'Past' END AS event_state " +
              "FROM events e " +
              "JOIN categories c ON e.category_id = c.category_id " +
              "WHERE e.status = 'active' " +
              "ORDER BY e.event_date ASC";
    connection.query(sql,(err, records) => {
        if (err) {
            console.error("Error while retrieving the data: " + err);
            res.status(500).send({error: "Error while retrieving the data"});
        } else {
            res.send(records);
        }
    });
});
/* ---------- GET /api/events/categories ----------
   Returns all categories for the search filter dropdown.
   IMPORTANT: must be declared BEFORE "/:id" */
router.get("/categories", (req, res) => {
    connection.query("SELECT * FROM categories ORDER BY category_name", (err, records) =>
    {
        if (err) {
            console.error("Error while retrieving the data: " + err);
            res.status(500).send({error: "Error while retrieving the data"});
        } else {
            res.send(records);
        }
    })
})
/* ---------- GET /api/events/search?date=&location=&category= ----------
   Search endpoint - supports any combination of the three criteria. */
router.get("/search", (req, res) => {
    var date = req.query.date;
    var location = req.query.location;
    var category = req.query.category;
    
    var sql = "SELECT e.event_id, e.event_name, e.event_date, e.location, " +
              "e.ticket_price, e.image_url, c.category_name, " +
              "CASE WHEN e.event_date >= NOW() THEN 'Upcoming' ELSE 'Past' END AS event_state " +
              "FROM events e " +  
              "JOIN categories c ON e.category_id = c.category_id " +
              "WHERE e.status = 'active' ";
    var params = [];
    if (date) {
        sql += " AND DATE(e.event_date) = ? ";
        params.push(date);
    }
    if (location) {
        sql += " AND e.location LIKE ? ";
        params.push("%" + location + "%");
    }   
    if (category) {
        sql += " AND c.category_id = ? ";
        params.push(category);
    }
    sql += " ORDER BY e.event_date ASC";
    connection.query(sql, params, (err, records) => {
        if (err) {
            console.error("Error while retrieving the data: " + err);
            res.status(500).send({error: "Error while retrieving the data"});
        } else {
            res.send(records);
        }
    });

});
/* GET /api/events/:id
   Used by the Event Details page. Takes the event ID from the URL
   (whatever replaces ":id") and returns that one event's info. */
router.get("/:id", (req, res) => {
    var sql = "SELECT e.*, c.category_name, o.org_name, o.mission, o.email, o.phone, " +
              "CASE WHEN e.event_date >= NOW() THEN 'Upcoming' ELSE 'Past' END AS event_state " +
              "FROM events e " +
              "JOIN categories c ON e.category_id = c.category_id " +
              "JOIN organisations o ON e.org_id = o.org_id " +
              "WHERE e.event_id = ? AND e.status = 'active'";

    connection.query(sql, [req.params.id], (err, records) => {
        if (err) {
            console.error("Error while retrieving event: " + err);
            res.status(500).send({ error: "Error while retrieving event" });
        } else if (records.length === 0) {
            // No matching event (or it's suspended) -> send 404
            res.status(404).send({ error: "Event not found" });
        } else {
            res.send(records[0]); // only one event, so return just that one
        }
    });
});
module.exports = router;