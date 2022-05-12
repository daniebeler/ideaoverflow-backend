const express = require('express')
const router = express.Router()
const database = require('../database')

router.get('/byid/:id', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
              SELECT *
              FROM project p 
              WHERE p.id = ${con.escape(req.params.id)}
              `, (err, user) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (user[0]) {
          return res.send(user[0])
        } else {
          return res.send({ status: 204 })
        }
      }
    })
  })
})

router.post('/create', async (req, res) => {
  console.log(req.body)
  database.getConnection((_err, con) => {
    con.query(`
    INSERT INTO project (fk_user_id, title, short_description, logo)
    VALUES (
      ${con.escape(req.body.owner_id)},
      ${con.escape(req.body.title)},
      ${con.escape(req.body.short_description)},
      ${con.escape(req.body.logo)})
    `, (err) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.status(200).json({ status: 200, header: 'Nice!', message: 'Your post is now online' })
      }
    })
  })
})

router.post('/projects', (req, res) => {
  let usernameFilter = ''
  let order = 'ORDER BY p.creation_date DESC'

  if (req.body.username) {
    usernameFilter = 'WHERE u.username = "' + req.body.username + '"'
  }

  if (req.body.sortingCriteria === 'newest') {
    order = 'ORDER BY p.creation_date DESC'
  } else if (req.body.sortingCriteria === 'likes') {
    order = 'ORDER BY upvotes DESC'
  } else if (req.body.sortingCriteria === 'oldest') {
    order = 'ORDER BY p.creation_date ASC'
  }

  database.getConnection((_err, con) => {
    con.query(`
      SELECT p.*, u.id as ownerid, u.profileimage, u.color, u.username
      FROM project p
      INNER JOIN user u ON p.fk_user_id = u.id
      ${usernameFilter}
      GROUP BY p.id 
      ${order} 
      limit ${req.body.take} 
      offset ${req.body.skip}`, (err, result) => {
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
