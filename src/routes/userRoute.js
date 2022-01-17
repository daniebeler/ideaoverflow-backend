const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')
const mailer = require('nodemailer')
const bcrypt = require('bcrypt')
const database = require('../database')

const pwStrength = /^(?=.*[A-Za-z])(?=.*\d)[\S]{6,}$/ // mindestens 6 Stellen && eine Zahl && ein Buchstabe

function createToken(id, email, username) {
  return jwt.sign({ id, email, username }, 'ideaoverflow420', { expiresIn: '1y' })
}

function sendMail(to, subject, text) {
  const transporter = mailer.createTransport({
    host: 'smtp.gmail.com',
    port: 465,
    secure: true,
    auth: {
      user: 'noreply.ideaoverflow@gmail.com',
      pass: 'Omemomemo420'
    }
  })

  const mailOptions = {
    from: 'noreply.ideaoverflow@gmail.com',
    to: to,
    subject: subject,
    text: text
  }

  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log('Email konnte nicht gesendet werden:')
      console.log(error)
    } else {
      console.log('Mail was sent.')
      console.log(info)
    }
  })
}

router.post('/register', async (req, res) => {
  database.getConnection((_err, con) => {
    if (!req.body.email || !req.body.username || !req.body.password1 || !req.body.password2) {
      con.release()
      return res.json({ header: 'Fehler', message: 'Informationen unvollständig.' })
    } else if (!pwStrength.test(req.body.password1)) {
      con.release()
      return res.json({ header: 'Fehler', message: 'Das Passwort muss mindestens 6 Zeichen lang sein. Darunter müssen mindestens ein Buchstabe und eine Zahl sein.' })
    } else if (req.body.password1 !== req.body.password2) {
      con.release()
      return res.json({ header: 'Fehler', message: 'Die Passwörter stimmen nicht überein.' })
    }

    con.query(`SELECT * FROM user WHERE email = ${con.escape(req.body.email)}`, (err, user) => {
      if (err) {
        con.release()
        return res.status(401).json({ err })
      } else if (user[0]) {
        con.release()
        return res.json({ header: 'Fehler', message: 'Dieser Benutzer existiert bereits.' })
      }

      // generate a 13 long alphanumeric verification code
      const code = '0' + Math.random().toString(36).substr(2)

      bcrypt.genSalt(512, (_err, salt) => {
        bcrypt.hash(req.body.password1, salt, (_err, enc) => {
          con.query(`
            INSERT INTO user (email, username, password, verificationcode, profileimage) 
            VALUES (${con.escape(req.body.email)}, ${con.escape(req.body.username)}, ${con.escape(enc)}, ${con.escape(code)}, ${con.escape(req.body.profileimage)})
            `, (err, _result) => {
            con.release()
            if (err) {
              return res.status(500).json({ err })
            }

            sendMail(req.body.email, 'Email verification', 'Open this link to enable your account: http://localhost:8100/verify/' + code)
            return res.json({ header: 'Gratuliere!', message: 'Der Benutzer wurde angelegt. Bitte bestätige noch deine E-Mail, sie kann auch im Spam-Ordner gelandet sein. Danach kannst du kannst dich anmelden.' })
          })
        })
      })
    })
  })
})

router.post('/login', async (req, res) => {
  if (!req.body.email || !req.body.password) {
    return res.json({ message: 'Bitte fülle alle Felder aus.' })
  } else {
    database.getConnection((_err, con) => {
      con.query(`SELECT * FROM user WHERE email = ${con.escape(req.body.email)}`, (err, users) => {
        if (err) {
          con.release()
          return res.status(404).json({ err })
        }

        if (users.length === 0) {
          con.release()
          return res.json({ message: 'Bist du sicher, dass du deine E-Mail richtig geschrieben hast? Diesen Benutzer gibt es nämlich nicht.' })
        }

        if (users[0].verified === 1 || users[0].verified === 2) {
          bcrypt.compare(req.body.password, users[0].password, (err, isMatch) => {
            if (err) {
              con.release()
              return res.status(500).json({ err })
            }
            if (!isMatch) {
              con.release()
              return res.json({ message: 'Das Passwort ist falsch.', wrongpw: true })
            } else {
              if (users[0].verified === 2) {
                con.query(`UPDATE user SET verified = 1, verificationcode = "" WHERE id = ${con.escape(users[0].id)}`, () => {
                  con.release()
                })
              }

              const usertoken = createToken(users[0].id, users[0].email, users[0].username)

              const answer = { message: 'Erfolgreich angemeldet.', token: usertoken }
              return res.json(answer)
            }
          })
        } else {
          return res.json({ message: 'Du bist noch nicht verifiziert. Willst du den Verifizierungslink erneut senden?', notverified: true })
        }
      })
    })
  }
})

router.get('/verify/:code', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`SELECT verified FROM user WHERE verificationcode = ${con.escape(req.params.code)}`, (err, result) => {
      if (err) {
        con.release()
        return res.status(500).json(err)
      } else if (result.length === 0 || result[0].verified === 1) {
        con.release()
        return res.status(200).json({ verified: false })
      } else {
        con.query(`UPDATE user SET verified = true, verificationcode = "" WHERE verificationcode = ${con.escape(req.params.code)}`, (err) => {
          con.release()
          if (err) {
            return res.status(500).json(err)
          }
          return res.status(200).json({ verified: true })
        })
      }
    })
  })
})

router.get('/databyuserid/:userid', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
            SELECT u.id, u.email, u.username, u.firstname, u.lastname, u.bio, u.creationdate, u.private, (select count(followee_id) from follower where followee_id = u.id) as followers, (select count(follower_id) from follower where follower_id = u.id) as following, u.country, u.state, u.website, u.github, u.dribbble, u.linkedin, u.twitter, u.instagram, u.profileimage
            FROM user u 
            WHERE u.id = ${con.escape(req.params.userid)}
            `, (err, schueler) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (schueler[0]) {
          return res.send(schueler[0])
        } else {
          return res.status(500).json({ message: 'user nicht gefunden' })
        }
      }
    })
  })
})

router.get('/databyusername/:username', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
            SELECT u.id, u.email, u.username, u.firstname, u.lastname, u.bio, u.creationdate, u.private, (select count(followee_id) from follower where followee_id = u.id) as followers, (select count(follower_id) from follower where follower_id = u.id) as following, u.country, u.state, u.website, u.dribbble, u.linkedin, u.github, u.twitter, u.instagram, u.profileimage
            FROM user u 
            WHERE u.username = ${con.escape(req.params.username)}
            `, (err, schueler) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (schueler[0]) {
          return res.send(schueler[0])
        } else {
          return res.status(500).json({ message: 'user nicht gefunden' })
        }
      }
    })
  })
})

router.post('/changedata', async (req, res) => {
  let fullBase64 = req.body.profilepicture
  if (!fullBase64) {
    fullBase64 = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEBLAEsAAD/4QBWRXhpZgAATU0AKgAAAAgABAEaAAUAAAABAAAAPgEbAAUAAAABAAAARgEoAAMAAAABAAIAAAITAAMAAAABAAEAAAAAAAAAAAEsAAAAAQAAASwAAAAB/+0ALFBob3Rvc2hvcCAzLjAAOEJJTQQEAAAAAAAPHAFaAAMbJUccAQAAAgAEAP/hDIFodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvADw/eHBhY2tldCBiZWdpbj0n77u/JyBpZD0nVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkJz8+Cjx4OnhtcG1ldGEgeG1sbnM6eD0nYWRvYmU6bnM6bWV0YS8nIHg6eG1wdGs9J0ltYWdlOjpFeGlmVG9vbCAxMS44OCc+CjxyZGY6UkRGIHhtbG5zOnJkZj0naHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyc+CgogPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9JycKICB4bWxuczp0aWZmPSdodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyc+CiAgPHRpZmY6UmVzb2x1dGlvblVuaXQ+MjwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICA8dGlmZjpYUmVzb2x1dGlvbj4zMDAvMTwvdGlmZjpYUmVzb2x1dGlvbj4KICA8dGlmZjpZUmVzb2x1dGlvbj4zMDAvMTwvdGlmZjpZUmVzb2x1dGlvbj4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PScnCiAgeG1sbnM6eG1wTU09J2h0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8nPgogIDx4bXBNTTpEb2N1bWVudElEPmFkb2JlOmRvY2lkOnN0b2NrOjlmODU2NzNjLTEyZDEtNDkwZS05ODZmLWIwNDFiM2Q2MzczODwveG1wTU06RG9jdW1lbnRJRD4KICA8eG1wTU06SW5zdGFuY2VJRD54bXAuaWlkOjFhYzVkYTFjLTM5ODQtNGVhNy05YTFiLWYyNzMzOTk4YTkyODwveG1wTU06SW5zdGFuY2VJRD4KIDwvcmRmOkRlc2NyaXB0aW9uPgo8L3JkZjpSREY+CjwveDp4bXBtZXRhPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo8P3hwYWNrZXQgZW5kPSd3Jz8+/9sAQwAFAwQEBAMFBAQEBQUFBgcMCAcHBwcPCwsJDBEPEhIRDxERExYcFxMUGhURERghGBodHR8fHxMXIiQiHiQcHh8e/9sAQwEFBQUHBgcOCAgOHhQRFB4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4e/8AAEQgBaAFoAwERAAIRAQMRAf/EABwAAQACAwEBAQAAAAAAAAAAAAAFBgEDBAcCCP/EADsQAQABAwICBQgJBAIDAAAAAAABAgMEBREVIQYxQVSTEiJVYXGRktETJEJScoGhscEUIzNi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'
  }

  const base64 = fullBase64.split(',')[1]
  const buffer = Buffer.from(base64, 'base64')

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
    profileimage = ${con.escape(buffer)}
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
