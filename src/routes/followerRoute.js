const express = require('express')
const router = express.Router()
const database = require('../database')
const passport = require('passport')

router.get('/followees/:id', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
          select follower_id, username
          from follower f
          inner join user u on followee_id = u.id
          where followee_id = ${con.escape(req.params.id)}
            `, (err, schueler) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (schueler[0]) {
          return res.send(schueler[0])
        } else {
          return res.status(500).json({ message: 'user nicht gefunden' })
        }
      }
    })
  })
})

router.post('/follow', passport.authenticate('userAuth', { session: false }), async (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
    INSERT INTO follower (follower_id, followee_id)
    VALUES (${con.escape(req.body.followerID)}, ${con.escape(req.body.followeeID)})
    `, (err) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.json({ status: 200, header: 'Juhuu', message: 'Stonks' }).send()
      }
    })
  })
})

router.post('/unfollow', passport.authenticate('userAuth', { session: false }), async (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
      DELETE FROM follower
      WHERE followee_id = ${con.escape(req.body.followeeID)} 
      AND follower_id = ${con.escape(req.body.followerID)}
    `, (err) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.json({ status: 200, header: 'Juhuu', message: 'Stonks' }).send()
      }
    })
  })
})

router.post('/checkfollow', async (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
      SELECT EXISTS(SELECT * FROM follower
      WHERE followee_id = ${con.escape(req.body.followeeID)} 
      AND follower_id = ${con.escape(req.body.followerID)}) as following
    `, (err, user) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.json({ following: user[0].following }).send()
      }
    })
  })
})

router.get('/followersbyusername/:username', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
    select u.*
      from follower f
      inner join user u on u.id = f.follower_id 
      where f.followee_id = (select id from user where username = ${con.escape(req.params.username)})
      `, (err, user) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(user)
      }
    })
  })
})

router.get('/followeesbyusername/:username', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
    select u.*
    from follower f
    inner join user u on u.id = f.followee_id 
    where f.follower_id = (select id from user where username = ${con.escape(req.params.username)})
      `, (err, user) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(user)
      }
    })
  })
})

module.exports = router
