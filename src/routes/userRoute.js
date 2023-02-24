const express = require('express')
const router = express.Router()
const bcrypt = require('bcrypt')
const { auth } = require('../middleware/userAuth')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.get('/databyuserid/:userid', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const userId = parseInt(req.params.userid)
  const result = await prisma.user.findFirst({
    where: { id: userId }
  })

  if (result) {
    return res.send(result)
  } else {
    return res.send({ status: 204 })
  }
}))

router.get('/databyusername/:username', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const result = await prisma.user.findFirst({
    where: { username: req.params.username }
  })

  if (result) {
    return res.send(result)
  } else {
    return res.send({ status: 204 })
  }
}))

router.get('/users', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const result = await prisma.user.findMany()
  return res.send(result)
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

  await prisma.user.update({
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

  return res.json({ status: 200, header: 'Juhuu', message: 'Stonks' }).send()
}))

router.post('/changepw', auth, use(async (req, res) => {
  // #swagger.tags = ['Users']

  const pwStrength = /^(?=.*[A-Za-z])(?=.*\d)[\S]{6,}$/ // mindestens 6 Stellen && eine Zahl && ein Buchstabe

  if (!req.body.oldPassword || !req.body.newPassword1 || !req.body.newPassword2 || !req.body.id) {
    return res.json({ header: 'Fehler', message: 'Informationen unvollständig!' })
  } else if (req.body.newPassword1 !== req.body.newPassword2) {
    return res.json({ header: 'Fehler', message: 'Neue Passwörter stimmen nicht überein!' })
  } else if (!pwStrength.test(req.body.newPassword1)) {
    return res.json({ header: 'Fehler', message: 'Das Passwort muss mindestens 6 Zeichen lang sein. Darunter müssen mindestens ein Buchstabe und eine Zahl sein.' })
  }

  const user = await prisma.user.findUnique({
    where: {
      id: req.body.id
    }
  })

  // FIX
  if (!user) {
    return res.json({ header: 'Fehler', message: 'Dieser Benutzer existiert nicht!' })
  }

  bcrypt.compare(req.body.oldPassword, user.password, (err, isMatch) => {
    if (err) {
      return res.status(500).json({ err })
    }
    if (isMatch) {
      bcrypt.genSalt(512, (_err, salt) => {
        bcrypt.hash(req.body.newPassword1, salt, async (_err, enc) => {
          await prisma.user.update({
            where: {
              id: req.body.id
            },
            data: {
              password: enc
            }
          })
          return res.json({ header: 'Erfolgreich!', message: 'Passwort wurde geändert!' })
        })
      })
    } else {
      return res.json({ header: 'Fehler', message: 'Das Passwort ist falsch!' })
    }
  })
}))

router.get('/numberoftotalusers', use(async (_req, res) => {
  // #swagger.tags = ['Users']

  const result = await prisma.user.count()
  return res.send({ numberoftotalusers: result })
}))

router.get('/numberofideasbyuser/:id', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const userId = parseInt(req.params.id)
  const result = await prisma.post.count({
    where: {
      fk_owner_user_id: userId
    }
  })

  return res.send({ numberofideas: result })
}))

router.get('/numberofprojectsbyuser/:id', use(async (req, res) => {
  // #swagger.tags = ['Users']

  const userId = parseInt(req.params.id)
  const result = await prisma.project.count({
    where: {
      fk_user_id: userId
    }
  })

  return res.send({ numberofprojects: result })
}))

module.exports = router
