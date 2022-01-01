const express = require('express')
const router = express.Router()
const database = require('../database')

router.post('/create', async (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
    INSERT INTO posts (OwnerUserId, Title, Body)
    VALUES (${con.escape(req.body.userID)}, ${con.escape(req.body.header)}, ${con.escape(req.body.body)})
    `, (err, user) => {
      if (err) {
        con.release()
        return res.status(500).json({ err })
      } else {
        con.release()
        return res.status(200).json({ status: 200, header: 'Juhuu', message: 'Stonks' })
      }
    })
  })
})

router.get('/latest', (req, res) => {
  database.getConnection((_err, con) => {
    con.query('SELECT * FROM posts', (err, result) => {
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (result[0]) {
          return res.send(result)
        } else {
          return res.status(500).json({ message: 'user nicht gefunden' })
        }
      }
    })
  })
})

module.exports = router
