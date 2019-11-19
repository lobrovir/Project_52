module.exports = function() {
  var express = require('express');
  var router = express.Router();

  function getPatients(res, mysql, context, complete) {
   mysql.pool.query("SELECT SSN, first_name, last_name, birthdate FROM patient, function(error, results, fields){
      if (error) {
        res.write(JSON.stringify(error));
        res.end();
      }
      context.patients = results; /*May need to change to patient, same possible issue with other pages*/ complete();
    });
}

router.get('/', function(req, res) {
  var callbackCount = 0;
  var context = {};
  var mysql = req.app.get('mysql');
  getPatients(res, mysql, context, complete);

  function complete() {
    callbackCount++;
    if (callbackCount >= 1) {
      res.render('patients', context);
    }

  }
});
/* Adds a patient*/

router.post('/', function(req, res) {
  console.log(req.body)
  var mysql = req.app.get('mysql');
  var sql = "INSERT INTO patient (SSN, first_name, last_name, birthdate) VALUES (?,?,?,?)";
  var inserts = [req.body.SSN, req.body.first_name, req.body.last_name, req.body.birthdate];
  sql = mysql.pool.query(sql, inserts, function(error, results, fields) {
    if (error) {
      console.log(JSON.stringify(error))
      res.write(JSON.stringify(error));
      res.end();
    } else {
      res.redirect('/patients');
    }
  });
});
