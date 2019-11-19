module.exports = function() {
  var express = require('express');
  var router = express.Router();

  function getMedications(res, pharmacy, context, complete) {
    pharmacy.pool.query("SELECT ID, name, p_safe FROM medication, function(error, results, fields){
      if (error) {
        res.write(JSON.stringify(error));
        res.end();
      }
      context.medications = results; complete();
    });
}

router.get('/', function(req, res) {
  var callbackCount = 0;
  var context = {};
  var pharmacy = req.app.get('pharmacy');
  getMedications(res, pharmacy, context, complete);

  function complete() {
    callbackCount++;
    if (callbackCount >= 1) {
      res.render('medications', context);
    }
  }
});
/* Adds a medication*/

router.post('/', function(req, res) {
  console.log(req.body)
  var pharmacy = req.app.get('pharmacy');
  var sql = "INSERT INTO medication (ID, name, p_safe) VALUES (?,?,?)";
  var inserts = [req.body.ID, req.body.name, req.body.p_safe];
  sql = pharmacy.pool.query(sql, inserts, function(error, results, fields) {
    if (error) {
      console.log(JSON.stringify(error))
      res.write(JSON.stringify(error));
      res.end();
    } else {
      res.redirect('/medications');
    }
  });
});
