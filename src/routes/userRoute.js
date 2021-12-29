const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')
const mailer = require('nodemailer')
const bcrypt = require('bcrypt')
const database = require('../database')
const fetch = require('node-fetch')

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
                            INSERT INTO user (email, username, password, verificationcode) 
                            VALUES (${con.escape(req.body.email)}, ${con.escape(req.body.username)}, ${con.escape(enc)}, ${con.escape(code)})
                            `, (err, _result) => {
            if (err) {
              con.release()
              return res.status(500).json({ err })
            }

            sendMail(req.body.email, 'Email verification', 'Open this link to enable your account: http://localhost:8100/verify/' + code)
            con.release()
            return res.json({ header: 'Gratuliere!', message: 'Der Benutzer wurde angelegt. Bitte bestätige noch deine E-Mail, sie kann auch im Spam-Ordner gelandet sein. Danach kannst du kannst dich anmelden.' })
          })
        })
      })
    })
  })
})

router.post('/login', async (req, res) => {
  database.getConnection((_err, con) => {
    if (!req.body.email || !req.body.password) {
      con.release()
      return res.json({ message: 'Bitte fülle alle Felder aus.' })
    } else {
      con.query(`SELECT * FROM user WHERE email = ${con.escape(req.body.email)}`, (err, users) => {
        if (err) {
          con.release()
          return res.status(404).json({ err })
        }

        if (users.length === 0) {
          return res.json({ message: 'Bist du sicher, dass du deine E-Mail richtig geschrieben hast? Diesen Benutzer gibt es nämlich nicht.' })
        }

        if (users[0].verified === 1 || users[0].verified === 2) {
          bcrypt.compare(req.body.password, users[0].password, (err, isMatch) => {
            if (err) {
              return res.status(500).json({ err })
            }
            if (!isMatch) {
              return res.json({ message: 'Das Passwort ist falsch.', wrongpw: true })
            } else {
              if (users[0].verified === 2) {
                con.query(`UPDATE user SET verified = 1, verificationcode = "" WHERE id = ${con.escape(users[0].id)}`)
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
    }
  })
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
        con.query(`UPDATE user SET verified = true, verificationcode = "" WHERE verificationcode = ${con.escape(req.params.code)}`, (err, result) => {
          if (err) {
            con.release()
            return res.status(500).json(err)
          }
          con.release()
          return res.status(200).json({ verified: true })
        })
      }
    })
  })
})

router.get('/daten/:id', (req, res) => {
  database.getConnection((_err, con) => {
    con.query(`
            SELECT u.id, u.email, u.username, u.firstname, u.lastname, u.private, u.country, u.state, u.website, u.github, u.dribbble, u.linkedin, u.twitter, u.instagram
            FROM user u 
            WHERE id = ${con.escape(req.params.id)}
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
            SELECT u.id, u.email, u.username, u.firstname, u.lastname, u.private, u.country, u.state, u.website, u.dribbble, u.linkedin, u.github, u.twitter, u.instagram
            FROM user u 
            WHERE username = ${con.escape(req.params.username)}
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
  const base64 = req.body.profilepicture.split(',')[1]
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
    instagram = ${con.escape(req.body.instagram)},
    twitter = ${con.escape(req.body.twitter)},
    dribbble = ${con.escape(req.body.dribbble)},
    github = ${con.escape(req.body.github)},
    linkedin = ${con.escape(req.body.linkedin)},
    website = ${con.escape(req.body.website)},
    profileimage = ${con.escape(buffer)}
    WHERE id = ${con.escape(req.body.id)}`, (err, user) => {
      if (err) {
        con.release()
        return res.status(500).json({ err })
      } else {
        con.release()
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
                if (err) {
                  con.release()
                  return res.status(500).json({ err })
                }
                con.release()
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

module.exports = router
