const mysql = require('mysql')

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'ideaoverflow',
  connectionLimit: 800,
  multipleStatements: false
})

exports.getConnection = function (callback) {
  pool.getConnection(function (err, con) {
    if (err) {
      return callback(err)
    }
    callback(err, con)
  })
}
