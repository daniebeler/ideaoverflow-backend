const express = require('express')
const router = express.Router()
const database = require('../database')

router.post('/create', async (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
    INSERT INTO posts (OwnerUserId, Title, Body)
    VALUES (${con.escape(req.body.userId)}, ${con.escape(req.body.title)}, ${con.escape(req.body.body)})
    `, (err, user) => {
      if (err) {
        con.release()
        return res.status(500).json({ err })
      } else {
        con.release()
        return res.json({ status: 200, header: 'Juhuu', message: 'Stonks' }).send()
      }
    })
  })
})

module.exports = router
