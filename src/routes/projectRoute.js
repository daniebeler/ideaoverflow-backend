const express = require('express')
const router = express.Router()
const { auth, optionalAuth } = require('../middleware/userAuth')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const helper = require('../helper')

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.get('/byid/:id', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Projects']

  const result = await prisma.project.findUnique({
    where: {
      id: parseInt(req.params.id)
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
      screenshot: {
        select: {
          url: true
        }
      }
    }
  })

  if (req.user?.id && result) {
    result.mine = req.user.id === result.user.id
  }

  if (!result) {
    return helper.returnError(res, 'Unknown error')
  } else {
    return helper.returnResult(res, result)
  }
}))

router.get('/all', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Projects']

  const query = helper.convertQuery(req.query)
  const result = await prisma.project.findMany({
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
    return helper.returnResult(res, result)
  } else {
    return helper.returnResult(res, [])
  }
}))

router.get('/byusername/:username', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Projects']

  const query = helper.convertQuery(req.query)
  const result = await prisma.project.findMany({
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
    return helper.returnResult(res, result)
  } else {
    return helper.returnResult(res, [])
  }
}))

router.post('/create', auth, use(async (req, res) => {
  // #swagger.tags = ['Projects']

  const result = await prisma.project.create({
    data: {
      fk_user_id: req.user.id,
      title: req.body.title,
      short_description: req.body.short_description,
      logo: req.body.logo,
      body: req.body.body,
      website: req.body.website,
      release_date: req.body.release_date
    }
  })

  await prisma.screenshot.createMany({
    data: req.body.screenshots.map(screenshot => ({
      fk_project_id: result.id,
      url: screenshot
    }))
  })

  if (!result) {
    return helper.returnError(res, 'Unknown error')
  } else {
    return helper.returnResult(res, result)
  }
}))

router.post('/update', auth, use(async (req, res) => {
  // #swagger.tags = ['Projects']

  if (/^(http:\/\/)/.test(req.body.website)) {
    req.body.website = req.body.website.slice(7)
  } else if (/^(https:\/\/)/.test(req.body.website)) {
    req.body.website = req.body.website.slice(8)
  }

  req.body.release_date = new Date(req.body.release_date)
  req.body.start_date = new Date(req.body.start_date)

  const result = await prisma.project.update({
    where: {
      id: parseInt(req.body.id)
    },
    data: {
      title: req.body.title,
      short_description: req.body.short_description,
      logo: req.body.logo,
      body: req.body.body,
      website: req.body.website,
      release_date: req.body.release_date,
      start_date: req.body.start_date
    }
  })

  if (!result) {
    return helper.returnError(res, 'Unknown error')
  } else {
    return helper.returnResult(res)
  }
}))

router.get('/numberoftotalprojects', use(async (_req, res) => {
  // #swagger.tags = ['Projects']

  const result = await prisma.project.count()
  return helper.returnResult(res, { numberoftotalprojects: result })
}))

module.exports = router
