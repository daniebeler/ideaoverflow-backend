const express = require('express')
const router = express.Router()
const database = require('../database')
const { auth } = require('../middleware/userAuth')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const helper = require('../helper')

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.post('/follow', auth, use(async (req, res) => {
  // #swagger.tags = ['Followers']

  await prisma.follower.create({
    data: {
      follower_id: req.body.followerID,
      followee_id: req.body.followeeID
    }
  })

  return helper.resSend(res, { status: 200 })
}
))

router.post('/unfollow', auth, async (req, res) => {
  // #swagger.tags = ['Followers']

  await prisma.follower.deleteMany({
    where: {
      follower_id: req.body.followerID,
      followee_id: req.body.followeeID
    }
  })

  return helper.resSend(res, { status: 200 })
})

router.post('/checkfollow', async (req, res) => {
  // #swagger.tags = ['Followers']

  database.dbGetSingleValue(
    'SELECT EXISTS(SELECT * FROM follower WHERE followee_id = ? AND follower_id = ?) as val',
    [req.body.followeeID, req.body.followerID],
    0,
    (result, err) => {
      if (err) {
        return helper.resSend(res, null, 'Error', 'Unknown error')
      } else {
        return helper.resSend(res, { following: result })
      }
    })
})

router.get('/followersbyusername/:username', (req, res) => {
  // #swagger.tags = ['Followers']

  database.dbQuery(
    'select u.* from follower f inner join user u on u.id = f.follower_id where f.followee_id = (select id from user where username = ?)',
    [req.params.username],
    (result, err) => {
      if (err) {
        return helper.resSend(res, null, 'Error', 'Unknown error')
      } else {
        return helper.resSend(res, result)
      }
    })
})

router.get('/followeesbyusername/:username', (req, res) => {
  // #swagger.tags = ['Followers']

  database.dbQuery(
    'select u.* from follower f inner join user u on u.id = f.followee_id where f.follower_id = (select id from user where username = ?)',
    [req.params.username],
    (result, err) => {
      if (err) {
        return helper.resSend(res, null, 'Error', 'Unknown error')
      } else {
        return helper.resSend(res, result)
      }
    })
})

module.exports = router
