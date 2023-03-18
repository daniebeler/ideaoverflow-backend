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
    return helper.returnError(res, 'Empty fields')
  }

  if (!helper.testPasswordStrength(req.body.password)) {
    return helper.returnError(res, 'The password must be at least 6 characters long. There must be at least one letter and one number.')
  }

  if (!helper.checkIfIsEmail(req.body.email)) {
    return helper.returnError(res, 'Invalid email')
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
      return helper.returnError(res, 'This email is already used')
    } else {
      return helper.returnError(res, 'This username is already used')
    }
  }

  const code = helper.generateRandomString()

  bcrypt.genSalt(512, (_err, salt) => {
    bcrypt.hash(req.body.password, salt, async (_err, enc) => {
      const newUser = await prisma.user.create({
        data: {
          email: req.body.email,
          username: req.body.username,
          password: enc,
          verificationcode: code
        }
      })

      const usertoken = helper.createJWT(
        newUser.id,
        newUser.email,
        newUser.username
      )
      helper.returnResult(res, { token: usertoken })
    })
  })
}))

router.post('/login', use(async (req, res) => {
  // #swagger.tags = ['Authentication']
  // #swagger.description = 'Login a user.'

  if (!req.body.email || !req.body.password) {
    return helper.returnError(res, 'Empty fields')
  }

  const foundUser = await prisma.user.findFirst({
    where: {
      email: req.body.email
    },
    select: {
      password: true,
      id: true,
      email: true
    }
  })

  if (!foundUser) {
    return helper.returnError(res, 'Wrong email or password')
  }

  bcrypt.compare(req.body.password, foundUser.password, async (err, isMatch) => {
    if (err) {
      return helper.returnError(res, 'Unknown error')
    }

    if (!isMatch) {
      return helper.returnError(res, 'Wrong email or password')
    }

    const usertoken = helper.createJWT(foundUser.id, foundUser.email, foundUser.username)
    return helper.returnResult(res, { token: usertoken })
  })
}))

router.get('/verify/:code', use(async (req, res) => {
  // #swagger.tags = ['Authentication']

  const result = await prisma.user.findFirst({
    where: {
      verificationcode: req.params.code
    }
  })

  if (result?.verified === 1) {
    return helper.returnResult(res, { verified: false })
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
    return helper.returnResult(res, { verified: true })
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
    return helper.returnError(res, 'Failed to send mail!')
  }

  helper.sendMail(req.body.email, 'Email verification', 'Open this link to enable your account: https://ideaoverflow.xyz/verify/' + result.verificationcode)
  return helper.returnResult(res)
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
    return helper.returnError(res, 'Email does not exist')
  }

  helper.sendMail(req.body.email,
    'Reset password',
    'Open the following link to reset your password: https://ideaoverflow.xyz/resetpassword/' + code)
  return helper.returnResult(res)
}))

router.get('/checkresetcode/:code', use(async (req, res) => {
  // #swagger.tags = ['Authentication']

  const result = await prisma.user.findFirst({
    where: {
      verificationcode: req.params.code
    }
  })

  if (!result) {
    return helper.returnResult(res, { exists: false })
  } else {
    return helper.returnResult(res, { exists: true })
  }
}))

router.post('/setpassword', use(async (req, res) => {
  // #swagger.tags = ['Authentication']

  if (!req.body.pw1 || !req.body.pw2) {
    return helper.returnError(res, 'Missing information')
  }

  if (req.body.pw1 !== req.body.pw2) {
    return helper.returnError(res, 'Passwords are not the same')
  }

  if (!helper.testPasswordStrength(req.body.pw1)) {
    return helper.returnError(res, 'The password must be at least 6 characters long. There must be at least one letter and one number')
  }

  const foundUser = await prisma.user.findFirst({
    where: {
      verificationcode: req.body.vcode
    }
  })

  if (!foundUser) {
    return helper.returnError(res, 'This code does not exist')
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

      return helper.returnResult(res)
    })
  })
}))

module.exports = router
