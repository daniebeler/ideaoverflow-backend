/* eslint-disable camelcase */
const express = require('express')
const router = express.Router()
const { auth, optionalAuth } = require('../middleware/userAuth')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const helper = require('../helper')

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.get('/byid/:id', optionalAuth, use(async (req, res) => {
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
      },
      user_saves_post: {
        where: {
          user_id: req?.user?.id
        }
      }
    }
  })

  const upvotes = await prisma.vote.count({
    where: {
      post_id: result.id,
      value: 1
    }
  })

  const downvotes = await prisma.vote.count({
    where: {
      post_id: result.id,
      value: -1
    }
  })

  if (req.user?.id) {
    const votevalue = await prisma.vote.findFirst({
      where: {
        post_id: ideaId,
        user_id: req.user?.id
      },
      select: {
        value: true
      }
    })

    result.votevalue = votevalue?.value ?? 0
  }

  result.upvotes = upvotes
  result.downvotes = downvotes
  result.saved = result.user_saves_post.length !== 0

  delete result.user_saves_post

  if (result) {
    return helper.resSend(res, result)
  } else {
    return helper.resSend(res, {})
  }
}))

router.get('/byusername/:username', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const query = helper.convertQuery(req.query)
  let result = await prisma.post.findMany({
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

  result = await getUpAndDownVotes(result)

  if (result) {
    return helper.resSend(res, result)
  } else {
    return helper.resSend(res, [])
  }
}))

router.get('/saved', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const query = helper.convertQuery(req.query)
  let result = await prisma.user_saves_post.findMany({
    skip: query.skip ?? 0,
    take: query.take ?? 100,
    orderBy: {
      post: {
        creation_date: query.orderDirection
      }
    },
    where: {
      user_id: req.user.id
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
      },
      post: true
    }
  })

  result = await getUpAndDownVotes(result)

  result.forEach(function (element) {
    element.id = element.post.id
    element.title = element.post.title
    element.body = element.post.body
    delete element.post
    delete element.user_id
    delete element.post_id
    delete element.savedAt
  })

  if (result) {
    return helper.resSend(res, result)
  } else {
    return helper.resSend(res, [])
  }
}))

router.get('/all', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const query = helper.convertQuery(req.query)
  const sortBy = query.sort ?? 'date'

  console.log('query', query)

  let result

  if (sortBy === 'date') {
    result = await prisma.post.findMany({
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
  } else if (sortBy === 'likes') {
    console.log('likes')
    result = await prisma.post.findMany({
      skip: query.skip ?? 0,
      take: query.take ?? 100,
      where: {
        vote: {
          every: { value: 1 }
        }
      },
      orderBy: {
        vote: {
          _count: 'desc'
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
  }

  if (req.user?.id) {
    // eslint-disable-next-line array-callback-return
    result.map(idea => {
      idea.mine = req.user.id === idea.user.id
    })
  }

  result = await getUpAndDownVotes(result)

  if (result) {
    return helper.resSend(res, result)
  } else {
    return helper.resSend(res, [])
  }
}))

const getUpAndDownVotes = async (result) => {
  const upvotes = await prisma.vote.groupBy({
    by: ['post_id'],
    where: {
      value: 1
    },
    _count: {
      post_id: true
    }
  })

  const downvotes = await prisma.vote.groupBy({
    by: ['post_id'],
    where: {
      value: -1
    },
    _count: {
      post_id: true
    }
  })

  // eslint-disable-next-line array-callback-return
  result.map(idea => {
    idea.upvotes = upvotes.find((upvote) => upvote.post_id === idea.id)?._count?.post_id ?? 0
  })

  // eslint-disable-next-line array-callback-return
  result.map((idea) => {
    idea.downvotes = downvotes.find((downvote) => downvote.post_id === idea.id)?._count?.post_id ?? 0
  })
  return result
}

router.post('/create', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  await prisma.post.create({
    data: {
      fk_owner_user_id: req.user.id,
      title: req.body.header,
      body: req.body.body
    }
  })

  return helper.resSend(res)
}))

router.post('/update', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  await prisma.post.update({
    where: {
      id: parseInt(req.body.ideaId)
    },
    data: {
      title: req.body.title,
      body: req.body.body
    }
  })

  return helper.resSend(res)
}))

router.get('/numberoftotalideas', use(async (_req, res) => {
  // #swagger.tags = ['Ideas']

  const numberoftotalideas = await prisma.post.count()
  return helper.resSend(res, { numberoftotalideas })
}))

router.post('/vote', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const result = await prisma.vote.upsert({
    where: {
      user_id_post_id: {
        user_id: req.user.id,
        post_id: req.body.ideaId
      }
    },
    update: {
      value: req.body.voteValue
    },
    create: {
      user_id: req.user.id,
      post_id: req.body.ideaId,
      value: req.body.voteValue
    }
  })

  return helper.resSend(res, result)
}))

router.post('/save', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const result = await prisma.user_saves_post.upsert({
    where: {
      user_id_post_id: {
        user_id: req.user.id,
        post_id: req.body.ideaId
      }
    },
    update: {},
    create: {
      user_id: req.user.id,
      post_id: req.body.ideaId
    }
  })

  return helper.resSend(res, result)
}))

router.post('/unsave', auth, use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  await prisma.user_saves_post.deleteMany({
    where: {
      user_id: req.body.userId,
      post_id: req.body.ideaId
    }
  })

  return helper.resSend(res, { success: true })
}))

module.exports = router
