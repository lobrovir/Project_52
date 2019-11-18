module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getClinics(res, mysql, context, complete){
        mysql.pool.query("SELECT ID, name, address, city, state, zip FROM clinic, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.people = results;
            complete();
        });
    }

    /*Display all people. Requires web based javascript to delete users with AJAX*/

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');
        getClinics(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('clinic', context);
            }

        }
    });


    /* Adds a person, redirects to the people page after adding */

    router.post('/', function(req, res){
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO clinic (ID, name, address, city, state, zip) VALUES (?,?,?,?,?,?)";
        var inserts = [req.body.ID, req.body.name, req.body.address,req.body.city,req.body.state,req.body.zip];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/clinics');
            }
        });
    });


