const JwtStrategy = require('passport-jwt').Strategy
const ExtractJwt = require('passport-jwt').ExtractJwt
const database = require('../database')

const opts = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: 'ideaoverflow420'
}

module.exports = new JwtStrategy(opts, function (jwtPayload, done) {
  database.dbGetSingleRow('SELECT * FROM user WHERE id = ?', [jwtPayload.id], (user, err) => {
    if (err) {
      return done(err, false)
    }
    if (user) {
      return done(null, user)
    } else {
      return done(null, false)
    }
  })
})
