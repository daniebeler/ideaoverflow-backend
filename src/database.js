var mysql = require('mysql');

var pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'ideaoverflowdb',
    connectionLimit: 400,
    multipleStatements: false
});

exports.getConnection = function(callback) {
  pool.getConnection(function(err, con) {
    if(err) {
      return callback(err);
    }
    callback(err, con);
  });
};