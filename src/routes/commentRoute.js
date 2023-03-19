const express = require('express')
const router = express.Router()
const { auth, optionalAuth } = require('../middleware/userAuth')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const helper = require('../helper')

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.get('/byidea/:id', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Comments']

  const result = await prisma.comment.findMany({
    where: {
      fk_idea_id: parseInt(req.params.id)
    },
    orderBy: {
      creation_date: 'desc'
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

  if (req.user?.id) {
    // eslint-disable-next-line array-callback-return
    result.map(comment => {
      comment.mine = req.user.id === comment.user.id
    })
  }

  if (!result) {
    return helper.returnError(res, 'Unknown error')
  } else {
    return helper.returnResult(res, result)
  }
}))

router.get('/byproject/:id', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Comments']

  const result = await prisma.comment.findMany({
    where: {
      fk_project_id: parseInt(req.params.id)
    },
    orderBy: {
      creation_date: 'desc'
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

  if (req.user?.id) {
    // eslint-disable-next-line array-callback-return
    result.map(comment => {
      comment.mine = req.user.id === comment.user.id
    })
  }

  if (!result) {
    return helper.returnError(res, 'Unknown error')
  } else {
    return helper.returnResult(res, result)
  }
}))

router.post('/create', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  await prisma.comment.create({
    data: {
      fk_idea_id: req.body.ideaId,
      fk_project_id: req.body.projectId,
      fk_user_id: req.user.id,
      body: req.body.comment
    }
  })

  return helper.returnResult(res)
}))

router.post('/delete', auth, use(async (req, res) => {
  // #swagger.tags = ['Followers']

  const commentId = parseInt(req.body.commentId)

  await prisma.comment.delete({
    where: {
      id: commentId
    }
  })

  return helper.returnResult(res)
}))

module.exports = router
