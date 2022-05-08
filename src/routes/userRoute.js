const express = require('express')
const router = express.Router()
const bcrypt = require('bcrypt')
const database = require('../database')

router.get('/databyuserid/:userid', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
            SELECT u.id, u.email, u.username, u.firstname, u.lastname, u.bio, u.creationdate, u.private, (select count(followee_id) from follower where followee_id = u.id) as followers, (select count(follower_id) from follower where follower_id = u.id) as following, u.country, u.state, u.website, u.github, u.dribbble, u.linkedin, u.twitter, u.instagram, u.profileimage, u.color
            FROM user u 
            WHERE u.id = ${con.escape(req.params.userid)}
            `, (err, user) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (user[0]) {
          return res.send(user[0])
        } else {
          return res.send({ status: 204 })
        }
      }
    })
  })
})

router.get('/databyusername/:username', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
            SELECT u.id, u.email, u.username, u.firstname, u.lastname, u.bio, u.creationdate, u.private, (select count(followee_id) from follower where followee_id = u.id) as followers, (select count(follower_id) from follower where follower_id = u.id) as following, u.country, u.state, u.website, u.dribbble, u.linkedin, u.github, u.twitter, u.instagram, u.profileimage, u.color
            FROM user u 
            WHERE u.username = ${con.escape(req.params.username)}
            `, (err, user) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (user[0]) {
          return res.send(user[0])
        } else {
          return res.send({ status: 204 })
        }
      }
    })
  })
})

router.get('/users', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
    select *
    from user
      `, (err, user) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(user)
      }
    })
  })
})

router.get('/usersbysearchterm/:searchterm', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
    select *
    from user
    where username = ${con.escape(req.params.searchterm)}
      `, (err, user) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(user)
      }
    })
  })
})

router.post('/changedata', async (req, res) => {
  if (/^(http:\/\/)/.test(req.body.website)) {
    req.body.website = req.body.website.slice(7)
    console.log(req.body.website)
  } else if (/^(https:\/\/)/.test(req.body.website)) {
    req.body.website = req.body.website.slice(8)
    console.log(req.body.website)
  }

  database.getConnection((_err, con) => {
    con.query(`
    UPDATE user
    SET 
    firstname = ${con.escape(req.body.firstname)},
    lastname = ${con.escape(req.body.lastname)},
    private = ${con.escape(req.body.private)},
    country = ${con.escape(req.body.country)},
    state = ${con.escape(req.body.state)},
    bio = ${con.escape(req.body.bio)},
    instagram = ${con.escape(req.body.instagram)},
    twitter = ${con.escape(req.body.twitter)},
    dribbble = ${con.escape(req.body.dribbble)},
    github = ${con.escape(req.body.github)},
    linkedin = ${con.escape(req.body.linkedin)},
    website = ${con.escape(req.body.website)},
    profileimage = ${con.escape(req.body.profilepicture)},
    color = ${con.escape(req.body.color)}
    WHERE id = ${con.escape(req.body.id)}`, (err) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.json({ status: 200, header: 'Juhuu', message: 'Stonks' }).send()
      }
    })
  })
})

router.post('/changepw', async (req, res) => {
  database.getConnection((_err, con) => {
    const pwStrength = /^(?=.*[A-Za-z])(?=.*\d)[\S]{6,}$/ // mindestens 6 Stellen && eine Zahl && ein Buchstabe

    if (!req.body.oldPassword || !req.body.newPassword1 || !req.body.newPassword2 || !req.body.id) {
      con.release()
      return res.json({ header: 'Fehler', message: 'Informationen unvollständig!' })
    } else if (req.body.newPassword1 !== req.body.newPassword2) {
      con.release()
      return res.json({ header: 'Fehler', message: 'Neue Passwörter stimmen nicht überein!' })
    } else if (!pwStrength.test(req.body.newPassword1)) {
      con.release()
      return res.json({ header: 'Fehler', message: 'Das Passwort muss mindestens 6 Zeichen lang sein. Darunter müssen mindestens ein Buchstabe und eine Zahl sein.' })
    }

    con.query(`SELECT * FROM user WHERE id = ${con.escape(req.body.id)}`, (err, users) => {
      if (err) {
        con.release()
        return res.status(400).json({ err })
      }
      if (users.length === 0) {
        con.release()
        return res.json({ header: 'Fehler', message: 'Dieser Benutzer existiert nicht!' })
      }

      bcrypt.compare(req.body.oldPassword, users[0].password, (err, isMatch) => {
        if (err) {
          con.release()
          return res.status(500).json({ err })
        }
        if (isMatch) {
          bcrypt.genSalt(512, (_err, salt) => {
            bcrypt.hash(req.body.new, salt, (_err, enc) => {
              con.query(`UPDATE user SET password = ${con.escape(enc)} WHERE id = ${con.escape(req.body.id)}`, (err) => {
                con.release()
                if (err) {
                  return res.status(500).json({ err })
                }
                return res.json({ header: 'Erfolgreich!', message: 'Passwort wurde geändert!' })
              })
            })
          })
        } else {
          con.release()
          return res.json({ header: 'Fehler', message: 'Das Passwort ist falsch!' })
        }
      })
    })
  })
})

router.get('/numberoftotalusers', (_req, res) => {
  database.getConnection((_err, con) => {
    con.query('SELECT count(id) as numberoftotalusers FROM user', (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result[0])
      }
    })
  })
})

module.exports = router
