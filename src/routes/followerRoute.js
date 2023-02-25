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

// löschen
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

router.get('/followersbyuserid/:id', use(async (req, res) => {
  // #swagger.tags = ['Followers']

  const result = await prisma.follower.findMany({
    where: {
      followee_id: parseInt(req.params.id)
    },
    include: {
      user_follower_follower_idTouser: {
        select: {
          id: true,
          username: true,
          profileimage: true,
          color: true
        }
      }
    }
  })

  result.forEach(function (obj) {
    obj.user = obj.user_follower_follower_idTouser
    delete obj.user_follower_follower_idTouser
    delete obj.followee_id
    delete obj.follower_id
  })

  if (!result) {
    return helper.resSend(res, null, 'Error', 'Unknown error')
  } else {
    return helper.resSend(res, result)
  }
}))

router.get('/followeesbyuserid/:id', use(async (req, res) => {
  // #swagger.tags = ['Followers']

  const result = await prisma.follower.findMany({
    where: {
      follower_id: parseInt(req.params.id)
    },
    include: {
      user_follower_followee_idTouser: {
        select: {
          id: true,
          username: true,
          profileimage: true,
          color: true
        }
      }
    }
  })

  result.forEach(function (obj) {
    obj.user = obj.user_follower_followee_idTouser
    delete obj.user_follower_followee_idTouser
    delete obj.followee_id
    delete obj.follower_id
  })

  if (!result) {
    return helper.resSend(res, null, 'Error', 'Unknown error')
  } else {
    return helper.resSend(res, result)
  }
}))

module.exports = router
