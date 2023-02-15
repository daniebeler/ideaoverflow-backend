/* eslint-disable camelcase */
const express = require('express')
const router = express.Router()
const database = require('../database')
const auth = require('../middleware/userAuth')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const helper = require('../helper')

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.get('/byid/:id', use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const ideaId = parseInt(req.params.id)
  const result = await prisma.post.findUnique({
    where: {
      id: ideaId
    },
    include: {
      user: {
        select: {
          id: true,
          username: true,
          firstname: true,
          lastname: true,
          profileimage: true,
          color: true
        }
      }
    }
  })

  if (result) {
    return res.send(result)
  } else {
    return res.send({ status: 204 })
  }
}))

router.get('/byusername/:username', use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  console.log(req.query)
  const query = helper.convertQuery(req.query)
  const result = await prisma.post.findMany({
    skip: query.skip ?? 0,
    take: query.take ?? 100,
    orderBy: {
      creation_date: query.orderDirection
    },
    where: {
      user: {
        username: req.params.username
      }
    },
    include: {
      user: {
        select: {
          id: true,
          username: true,
          firstname: true,
          lastname: true,
          profileimage: true,
          color: true
        }
      }
    }
  })

  if (result) {
    return res.send(result)
  } else {
    return res.send({ status: 204 })
  }
}))

router.get('/all', use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const query = helper.convertQuery(req.query)
  const result = await prisma.post.findMany({
    skip: query.skip ?? 0,
    take: query.take ?? 100,
    orderBy: {
      creation_date: query.orderDirection
    },
    include: {
      user: {
        select: {
          id: true,
          username: true,
          firstname: true,
          lastname: true,
          profileimage: true,
          color: true
        }
      }
    }
  })

  if (result) {
    return res.send(result)
  } else {
    return res.send({ status: 204 })
  }
}))

router.post('/create', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  await prisma.post.create({
    data: {
      fk_owner_user_id: req.body.userID,
      title: req.body.header,
      body: req.body.body
    }
  })

  return res.send({ status: 200, header: 'Nice!', message: 'Your idea is now online!' })
}))

router.post('/update', auth, async (req, res) => {
  // #swagger.tags = ['Ideas']

  await prisma.post.update({
    where: {
      id: req.body.postId
    },
    data: {
      title: req.body.title,
      body: req.body.body
    }
  })

  return res.send({ status: 200, header: 'Nice!', message: 'Your idea has been updated!' })
})

router.get('/numberoftotalideas', async (req, res) => {
  // #swagger.tags = ['Ideas']

  const numberoftotalideas = await prisma.post.count()
  return res.send({ numberoftotalideas })
})

router.post('/vote', auth, (req, res) => {
  // #swagger.tags = ['Ideas']

  database.getConnection((_err, con) => {
    con.query(`
      INSERT INTO vote (user_id, post_id, value)
      VALUES(${req.body.userId}, ${req.body.ideaId}, ${req.body.voteValue})
      ON DUPLICATE KEY UPDATE value = ${req.body.voteValue}
      `, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
  })
})

router.post('/save', auth, (req, res) => {
  // #swagger.tags = ['Ideas']

  database.getConnection((_err, con) => {
    con.query(`
      INSERT IGNORE INTO user_saves_post (user_id, post_id)
      VALUES(${req.body.userId}, ${req.body.ideaId})
      `, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
  })
})

router.post('/unsave', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  await prisma.user_saves_post.deleteMany({
    where: {
      user_id: req.body.userId,
      post_id: req.body.ideaId
    }
  })

  return res.send({ success: true })
}))

router.get('/checkifideabelongstouser/:postid', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']
  const postId = parseInt(req.params.postid)
  const result = await prisma.post.findFirst({
    where: {
      id: postId,
      fk_owner_user_id: req.user.id
    }
  })

  if (result) {
    return res.send({ accessgranted: true })
  } else {
    return res.send({ accessgranted: false })
  }
}))

module.exports = router
