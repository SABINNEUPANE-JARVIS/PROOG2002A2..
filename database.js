var dbDetails = require("./db-details");
var mysql = require('mysql2');

module.exports = {
    getconnection: () => {
        //uses createPool to manage multiple database connections.
        //This helps handle many requests at the same time.
        return mysql.createPool({
            host: dbDetails.host,
            user: dbDetails.user,
            password: dbDetails.password,
            database: dbDetails.database,
            waitForConnections: true,
            connectionLimit: 10,
            queueLimit: 0
        });
    }
};