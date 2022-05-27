const JwtStrategy = require('passport-jwt').Strategy
const ExtractJwt = require('passport-jwt').ExtractJwt
const database = require('../database')

const opts = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: 'ideaoverflow420'
}

module.exports = new JwtStrategy(opts, function (jwtPayload, done) {
  database.getConnection((_err, con) => {
    con.query(`SELECT * FROM user WHERE id = '${jwtPayload.id}'`, (err, user) => {
      con.release()
      if (err) {
        return done(err, false)
      }
      if (user.length > 0) {
        return done(null, user[0])
      } else return done(null, false)
    })
  })
})
