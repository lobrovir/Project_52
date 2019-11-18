module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getDoctors(res, mysql, context, complete){
        mysql.pool.query("SELECT doctor.ID as id, first_name, last_name, C_ID FROM doctor, function(error, results, fields){
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
        getDoctors(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('doctor', context);
            }

        }
    });


    /* Adds a person, redirects to the people page after adding */

    router.post('/', function(req, res){
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO doctor (ID,first_name, last_name, C_ID) VALUES (?,?,?,?)";
        var inserts = [req.body.ID, req.body.first_name, req.body.last_name, req.body.C_ID];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/doctors');
            }
        });
    });


