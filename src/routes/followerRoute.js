const express = require('express')
const router = express.Router()
const database = require('../database')
const passport = require('passport')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.post('/follow', passport.authenticate('userAuth', { session: false }), use(async (req, res) => {
  await prisma.follower.create({
    data: {
      follower_id: req.body.followerID,
      followee_id: req.body.followeeID
    }
  })
  return res.send({ status: 200 })
}
))

router.post('/unfollow', passport.authenticate('userAuth', { session: false }), async (req, res) => {
  await prisma.follower.deleteMany({
    where: {
      follower_id: req.body.followerID,
      followee_id: req.body.followeeID
    }
  })
  return res.send({ status: 200 })
})

router.post('/checkfollow', async (req, res) => {
  database.dbGetSingleValue(
    'SELECT EXISTS(SELECT * FROM follower WHERE followee_id = ? AND follower_id = ?) as val',
    [req.body.followeeID, req.body.followerID],
    0,
    (result, err) => {
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.json({ following: result }).send()
      }
    })
})

router.get('/followersbyusername/:username', (req, res) => {
  database.dbQuery(
    'select u.* from follower f inner join user u on u.id = f.follower_id where f.followee_id = (select id from user where username = ?)',
    [req.params.username],
    (result, err) => {
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
})

router.get('/followeesbyusername/:username', (req, res) => {
  database.dbQuery(
    'select u.* from follower f inner join user u on u.id = f.followee_id where f.follower_id = (select id from user where username = ?)',
    [req.params.username],
    (result, err) => {
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
})

module.exports = router
