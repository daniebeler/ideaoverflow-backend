const express = require('express')
const router = express.Router()
const bcrypt = require('bcrypt')
const { auth } = require('../middleware/userAuth')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const helper = require('../helper')
const functions = require('../functions')

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.get('/byid/:userid', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const userId = parseInt(req.params.userid)
  const result = await prisma.user.findFirst({
    where: { id: userId }
  })

  result.numberOfFollowers = await functions.getNumberOfFollowersByUserid(userId)
  result.numberOfFollowees = await functions.getNumberOfFolloweesByUserid(userId)
  result.numberOfPosts = await functions.getNumberOfIdeasByUserid(userId)
  result.numberOfProjects = await functions.getNumberOfProjectsByUserid(userId)

  if (result) {
    return helper.resSend(res, result)
  } else {
    return helper.resSend(res, {})
  }
}))

router.get('/byusername/:username', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const result = await prisma.user.findFirst({
    where: { username: req.params.username }
  })

  if (result?.id) {
    result.numberOfFollowers = await functions.getNumberOfFollowersByUserid(result.id)
    result.numberOfFollowees = await functions.getNumberOfFolloweesByUserid(result.id)
    result.numberOfPosts = await functions.getNumberOfIdeasByUserid(result.id)
    result.numberOfProjects = await functions.getNumberOfProjectsByUserid(result.id)
  }

  if (result) {
    return helper.resSend(res, result)
  } else {
    return helper.resSend(res, {})
  }
}))

router.get('/all', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const result = await prisma.user.findMany()
  return helper.resSend(res, result)
}))

router.get('/usersbysearchterm/:searchterm', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const result = await prisma.user.findMany({
    where: {
      username: req.params.searchterm
    }
  })

  return res.send(result)
}))

router.post('/changedata', auth, use(async (req, res) => {
  // #swagger.tags = ['Users']

  if (/^(http:\/\/)/.test(req.body.website)) {
    req.body.website = req.body.website.slice(7)
  } else if (/^(https:\/\/)/.test(req.body.website)) {
    req.body.website = req.body.website.slice(8)
  }

  const response = await prisma.user.update({
    where: {
      id: req.body.id
    },
    data: {
      firstname: req.body.firstname,
      lastname: req.body.lastname,
      country: req.body.country,
      state: req.body.state,
      bio: req.body.bio,
      instagram: req.body.instagram,
      twitter: req.body.twitter,
      dribbble: req.body.dribbble,
      github: req.body.github,
      linkedin: req.body.linkedin,
      website: req.body.website,
      profileimage: req.body.profilepicture,
      color: req.body.color
    }
  })

  if (!response) {
    return helper.resSend(res, null, 'Error', 'Unknown error')
  } else {
    return helper.resSend(res)
  }
}))

router.post('/changepw', auth, use(async (req, res) => {
  // #swagger.tags = ['Users']

  const pwStrength = /^(?=.*[A-Za-z])(?=.*\d)[\S]{6,}$/ // mindestens 6 Stellen && eine Zahl && ein Buchstabe

  if (!req.body.oldPassword || !req.body.newPassword) {
    return helper.resSend(res, null, 'Error', 'Information missing')
  } else if (!pwStrength.test(req.body.newPassword)) {
    return helper.resSend(res, null, 'Error', 'Password too weak')
  }

  const user = await prisma.user.findUnique({
    where: {
      id: req.user.id
    }
  })

  if (!user) {
    return helper.resSend(res, null, 'Error', 'Unknown Error')
  }

  bcrypt.compare(req.body.oldPassword, user.password, (err, isMatch) => {
    if (err) {
      return helper.resSend(res, null, 'Error', 'Unknown Error')
    }
    if (isMatch) {
      bcrypt.genSalt(512, (_err, salt) => {
        bcrypt.hash(req.body.newPassword, salt, async (_err, enc) => {
          await prisma.user.update({
            where: {
              id: req.user.id
            },
            data: {
              password: enc
            }
          })
          return helper.resSend(res)
        })
      })
    } else {
      return helper.resSend(res, null, 'Error', 'Wrong password')
    }
  })
}))

router.get('/numberoftotalusers', use(async (_req, res) => {
  // #swagger.tags = ['Users']

  const result = await prisma.user.count()
  return helper.resSend(res, { numberoftotalusers: result })
}))

module.exports = router
