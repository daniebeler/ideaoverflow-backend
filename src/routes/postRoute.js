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
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result[0])
      }
    })
  })
})

router.post('/posts', (req, res) => {
  let usernameFilter = ''
  let searchFilter = ''
  let savedFilter = ''
  let order = 'ORDER BY p.id'

  if (req.body.username) {
    usernameFilter = 'WHERE u.username = "' + req.body.username + '"'
  }

  if (req.body.searchTerm) {
    searchFilter = 'WHERE u.username LIKE "' + req.body.searchTerm + '"'
  }

  if (req.body.savedByUsername) {
    savedFilter = 'INNER JOIN user_saves_post s ON s.post_id = p.id WHERE s.user_id = ' + req.body.currentUserId
    order = 'ORDER BY s.savedAt DESC'
  }

  database.getConnection((_err, con) => {
    con.query(`
      SELECT p.*, u.*, vv.value as votevalue, (SELECT count(post_id) FROM vote v WHERE v.value = 1) as upvotes, (SELECT count(post_id) FROM vote v WHERE v.value = -1) as downvotes
      FROM post p
      INNER JOIN user u ON p.fk_owner_user_id = u.id
      LEFT JOIN (SELECT * FROM vote WHERE user_id = 1) vv ON p.fk_owner_user_id = vv.user_id
      LEFT JOIN vote v ON p.id = v.post_id
      ${savedFilter}
      ${usernameFilter}
      ${searchFilter}
      GROUP BY p.id
      ${order} 
      limit ${req.body.take} 
      offset ${req.body.skip}`, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        console.log(result)
        return res.send(result)
      }
    })
  })
})

router.post('/vote', (req, res) => {
  console.log('hola')
  database.getConnection((_err, con) => {
    con.query(`
      INSERT INTO vote (user_id, post_id, value)
      VALUES(${req.body.userId}, ${req.body.postId}, ${req.body.voteValue})
      ON DUPLICATE KEY UPDATE value = ${req.body.voteValue}
      `, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        console.log(result)
        return res.send(result)
      }
    })
  })
})

module.exports = router
