const jwt = require('jsonwebtoken')
const helper = require('../helper')

const auth = (req, res, next) => {
  let token
  if (req.headers.authorization) {
    token = req.headers.authorization.split(' ')[1]
  }

  if (!token) {
    return helper.returnError(res, 'A token is required for authentication')
  }
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET)
    req.user = decoded
  } catch (err) {
    return helper.returnError(res, 'Invalid Token')
  }
  return next()
}

const optionalAuth = (req, res, next) => {
  let token
  if (req.headers.authorization) {
    token = req.headers.authorization.split(' ')[1]
  }
  if (!token) {
    return next()
  } else {
    return auth(req, res, next)
  }
}

module.exports = {
  auth,
  optionalAuth
}
