module.exports = function() {
  var express = require('express');
  var router = express.Router();

  function getDoctors(res, pharmacy, context, complete) {
    pharmacy.pool.query("SELECT ID, first_name, last_name, C_ID FROM doctor, function(error, results, fields){
      if (error) {
        res.write(JSON.stringify(error));
        res.end();
      }
      context.doctors = results; complete();
    });
}

router.get('/', function(req, res) {
  var callbackCount = 0;
  var context = {};
  var pharmacy = req.app.get('pharmacy');
  getDoctors(res, pharmacy, context, complete);

  function complete() {
    callbackCount++;
    if (callbackCount >= 1) {
      res.render('doctor', context);
    }

  }
});
/* Adds a doctor*/

router.post('/', function(req, res) {
  console.log(req.body)
  var pharmacy = req.app.get('pharmacy');
  var sql = "INSERT INTO doctor (ID,first_name, last_name, C_ID) VALUES (?,?,?,?)";
  var inserts = [req.body.ID, req.body.first_name, req.body.last_name, req.body.C_ID];
  sql = pharmacy.pool.query(sql, inserts, function(error, results, fields) {
    if (error) {
      console.log(JSON.stringify(error))
      res.write(JSON.stringify(error));
      res.end();
    } else {
      res.redirect('/doctors');
    }
  });
});

