const express = require('express')
const router = express.Router()
const bcrypt = require('bcrypt')
const helper = require('../helper')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.post('/register', use(async (req, res) => {
  // #swagger.tags = ['Authentication']
  // #swagger.description = 'Registers a new user.'

  if (!req.body.email || !req.body.username || !req.body.password) {
    return res.json({ header: 'Error', message: 'Empty fields!' })
  } else if (!helper.testPasswordStrength(req.body.password)) {
    return res.json({ header: 'Error', message: 'The password must be at least 6 characters long. There must be at least one letter and one number.' })
  }

  const userCheck = await prisma.user.findFirst({
    where: {
      OR: [
        {
          email: req.body.email
        },
        {
          username: req.body.username
        }
      ]
    }
  })

  if (userCheck) {
    if (userCheck.email === req.body.email) {
      return res.json({ header: 'Error', message: 'This email is already used!' })
    } else {
      return res.json({ header: 'Error', message: 'This username already used!' })
    }
  }

  const code = helper.generateRandomString()

  bcrypt.genSalt(512, (_err, salt) => {
    bcrypt.hash(req.body.password, salt, async (_err, enc) => {
      await prisma.user.create({
        data: {
          email: req.body.email,
          username: req.body.username,
          password: enc,
          verificationcode: code
        }
      })

      helper.sendMail(req.body.email, 'Email verification', 'Open this link to enable your account: https://ideaoverflow.xyz/verify/' + code)
      return res.json({ status: 1, header: 'Congrats!', message: 'The user has been created. Please confirm your e-mail, it may have ended up in the spam folder. After that you can log in.' })
    })
  })
}))

router.post('/login', use(async (req, res) => {
  // #swagger.tags = ['Authentication']
  // #swagger.description = 'Login a user.'

  if (!req.body.email || !req.body.password) {
    return res.json({ message: 'Empty fields!' })
  } else {
    const foundUser = await prisma.user.findFirst({
      where: {
        email: req.body.email
      }
    })

    if (!foundUser) {
      return res.json({ message: 'This user does not exist!' })
    }

    if (foundUser.verified === 1 || foundUser.verified === 2) {
      bcrypt.compare(req.body.password, foundUser.password, async (err, isMatch) => {
        if (err) {
          return res.status(500).json({ err })
        }
        if (!isMatch) {
          return res.json({ message: 'Wrong password!', wrongpw: true })
        } else {
          if (foundUser.verified === 2) {
            await prisma.user.update({
              where: {
                id: foundUser.id
              },
              data: {
                verified: 1,
                verificationcode: ''
              }
            })
          }

          const usertoken = helper.createJWT(foundUser.id, foundUser.email, foundUser.username)
          const answer = { token: usertoken }
          return res.json(answer)
        }
      })
    } else {
      return res.json({ notverified: true })
    }
  }
}))

router.get('/verify/:code', use(async (req, res) => {
  // #swagger.tags = ['Authentication']

  const result = await prisma.user.findFirst({
    where: {
      verificationcode: req.params.code
    }
  })

  if (result?.verified === 1) {
    return res.status(200).json({ verified: false })
  } else {
    await prisma.user.update({
      where: {
        verificationcode: req.params.code
      },
      data: {
        verified: true,
        verificationcode: ''
      }
    })

    return res.status(200).json({ verified: true })
  }
}))

router.post('/sendverificationmailagain', use(async (req, res) => {
  // #swagger.tags = ['Authentication']

  const result = await prisma.user.findFirst({
    where: {
      email: req.body.email
    },
    select: {
      verificationcode: true
    }
  })

  if (!result) {
    return res.status(500).json({ header: 'Error', message: 'Failed to send mail!' })
  }

  helper.sendMail(req.body.email, 'Email verification', 'Open this link to enable your account: https://ideaoverflow.xyz/verify/' + result.verificationcode)
  return res.status(200).json({ header: 'Success!', message: 'Mail sent!' })
}))

router.post('/resetpassword', use(async (req, res) => {
  // #swagger.tags = ['Authentication']

  const code = helper.generateRandomString()

  const result = await prisma.user.update({
    where: {
      email: req.body.email
    },
    data: {
      verified: 2,
      verificationcode: code
    }
  })

  if (!result) {
    return res.status(200).json({ header: 'Fehler', message: 'Die E-Mail wurde nicht gefunden' })
  }

  helper.sendMail(req.body.email,
    'Reset password',
    'Open the following link to reset your password: https://ideaoverflow.xyz/resetpassword/' + code)
  return res.status(200).json({ header: 'Nice!', message: 'Mail sent to ' + req.body.email + '!' })
}))

router.get('/checkresetcode/:code', use(async (req, res) => {
  // #swagger.tags = ['Authentication']

  const result = await prisma.user.findFirst({
    where: {
      verificationcode: req.params.code
    }
  })

  if (!result) {
    return res.status(200).json({ message: 'This code does not exist!', exists: false })
  } else {
    return res.status(200).json({ exists: true })
  }
}))

router.post('/setpassword', async (req, res) => {
  // #swagger.tags = ['Authentication']

  if (!req.body.pw1 || !req.body.pw2) {
    return res.json({ header: 'Error', message: 'Informationen unvollständig!', stay: true })
  } else if (req.body.pw1 !== req.body.pw2) {
    return res.json({ header: 'Error', message: 'Passwords are not the same!', stay: true })
  } else if (!helper.testPasswordStrength(req.body.pw1)) {
    return res.json({ header: 'Error', message: 'The password must be at least 6 characters long. There must be at least one letter and one number.', stay: true })
  }

  const foundUser = await prisma.user.findFirst({
    where: {
      verificationcode: req.body.vcode
    }
  })

  if (!foundUser) {
    return res.json({ header: 'Error', message: 'This code does not exist', stay: false })
  }

  bcrypt.genSalt(512, (_err, salt) => {
    bcrypt.hash(req.body.pw1, salt, async (_err, enc) => {
      await prisma.user.update({
        where: {
          verificationcode: req.body.vcode
        },
        data: {
          verified: 1,
          password: enc,
          verificationcode: ''
        }
      })

      return res.json({ header: 'Congrats', message: 'Your password has been changed', stay: false })
    })
  })
})

module.exports = router
