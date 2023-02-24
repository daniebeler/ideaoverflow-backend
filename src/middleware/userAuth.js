const jwt = require('jsonwebtoken')

const auth = (req, res, next) => {
  let token
  if (req.headers.authorization) {
    token = req.headers.authorization.split(' ')[1]
  }

  if (!token) {
    return res.status(403).send('A token is required for authentication')
  }
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET)
    req.user = decoded
  } catch (err) {
    return res.status(401).send('Invalid Token')
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
