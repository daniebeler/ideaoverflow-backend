const mariadb = require('mariadb/callback')

const pool = mariadb.createPool({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'ideaoverflow',
  connectionLimit: 100,
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

  dbQuery: function (query, param, callback) {
    pool.query(query, param, (err, rows, metadata) => {
      if (err) {
        callback(undefined, err)
      } else {
        callback(rows, undefined)
      }
    })
  },

  dbGetSingleRow: function (query, param, callback) {
    this.dbQuery(query, param, (rows, err) => {
      if (err) {
        callback(undefined, err)
      } else {
        callback(rows[0], undefined)
      }
    })
  },

  dbGetSingleValue: function (query, param, defaultValue, callback) {
    this.dbGetSingleRow(query, param, (row, err) => {
      if (err) {
        callback(undefined, err)
      } else {
        const data = row.val ?? defaultValue
        callback(data, undefined)
      }
    })
  },

  dbInsert: function (query, param, callback) {
    this.dbQuery(query, param, (data, err) => {
      if (err) {
        callback(undefined, err)
      } else {
        callback(data.insertId, undefined)
      }
    })
  }
}
