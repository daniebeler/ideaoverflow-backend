const mariadb = require('mariadb/callback')

const pool = mariadb.createPool({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'ideaoverflow',
  connectionLimit: 800,
  charset: 'utf8mb4',
  collation: 'utf8mb4_general_ci',
  supportBigNumbers: true
})

module.exports = {
  getConnection: async function (callback) {
    pool.getConnection(function (err, con) {
      if (err) {
        return callback(err)
      }
      callback(err, con)
    })
  },

  dbQuery: async function (query, param, callback) {
    pool.query(query, param, (err, rows, metadata) => {
      if (err) {
        callback(undefined, err)
      } else {
        callback(rows)
      }
    })
  },
  dbGetSingleRow: async function (query, param) {
    const data = await this.dbQuery(query, param)
    return data[0]
  },
  dbGetSingleValue: async function (query, param, defaultValue) {
    let data = await this.dbGetSingleRow(query, param)
    data = data.val ?? defaultValue
    return data
  },
  dbInsert: async function (query, param) {
    const con = this.getConnection()
    const data = await con.promise().query(query, param)
    con.end()
    return data[0].insertId
  }
}
