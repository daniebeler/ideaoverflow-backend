const mariadb = require('mariadb/callback')

const pool = mariadb.createPool({
  host: '127.0.0.1',
  user: 'root',
  password: 'AUT-1251',
  database: 'ideaoverflow',
  connectionLimit: 800,
  charset: 'utf8mb4',
  collation: 'utf8mb4_general_ci',
  supportBigNumbers: true
})

exports.getConnection = function (callback) {
  pool.getConnection(function (err, con) {
    if (err) {
      return callback(err)
    }
    callback(err, con)
  })
}
