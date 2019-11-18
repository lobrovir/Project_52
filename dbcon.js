var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_osuname',
  password        : 'last4id',
  database        : 'cs340_osuname'
});
module.exports.pool = pool;