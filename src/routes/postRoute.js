const express = require('express')
const router = express.Router()
const database = require('../database')

router.post('/create', async (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
    INSERT INTO post (fk_owner_user_id, title, body)
    VALUES (${con.escape(req.body.userID)}, ${con.escape(req.body.header)}, ${con.escape(req.body.body)})
    `, (err) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.status(200).json({ status: 200, header: 'Juhuu', message: 'Stonks' })
      }
    })
  })
})

router.get('/numberoftotalposts', (req, res) => {
  console.log(req.params)
  database.getConnection((_err, con) => {
    con.query('SELECT count(id) as numberoftotalposts FROM post', (err, result) => {
      if (err) {
        con.release()
        return res.status(500).json({ err })
      } else {
        return res.send(result[0])
      }
    })
  })
})

router.get('/newest/:take/:skip', (req, res) => {
  console.log(req.params)
  database.getConnection((_err, con) => {
    con.query(`SELECT * FROM post ORDER BY id limit ${req.params.take} offset ${req.params.skip}`, (err, result) => {
      if (err) {
        con.release()
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
  })
})

router.get('/newest/:take/:skip/:username', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
      SELECT *
      FROM post p
      INNER JOIN user u
      ON p.fk_owner_user_id = u.id
      WHERE u.username = "${req.params.username}"
      ORDER BY p.id 
      limit ${req.params.take} 
      offset ${req.params.skip}`, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
  })
})

module.exports = router
