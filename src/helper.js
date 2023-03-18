const Str = require('@supercharge/strings')
const mailer = require('nodemailer')
const jwt = require('jsonwebtoken')

const pwStrength = /^(?=.*[A-Za-z])(?=.*\d)[\S]{6,}$/ // mindestens 6 Stellen && eine Zahl && ein Buchstabe
const email = /^\S+@\S+\.\S+$/

module.exports = {
  testPasswordStrength: function (password) {
    return pwStrength.test(password)
  },

  checkIfIsEmail: function (str) {
    return email.test(str)
  },

  createJWT: function (id, email, username) {
    return jwt.sign({ id, email, username }, process.env.JWT_SECRET, { expiresIn: '1y' })
  },

  generateRandomString: function () {
    return Str.random(90)
  },

  sendMail: function (to, subject, text) {
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
      to,
      subject,
      text
    }

    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        console.log(error)
      } else {
        console.log(info)
      }
    })
  },

  convertQuery: function (query) {
    const obj = {}
    obj.skip = parseInt(query.skip ?? 0)
    obj.take = parseInt(query.take ?? 100)
    obj.userId = parseInt(query.user_id ?? -1)
    obj.orderDirection = query.reverse === 'true' ? 'asc' : 'desc'
    obj.sort = query.sort

    return obj
  },

  returnResult(res, data) {
    data = data ?? {}

    const rspJson = {}
    rspJson.status = this.resStatuses.ok
    rspJson.data = data

    res.send(JSON.stringify(rspJson))
  },

  returnError(res, error) {
    error = error ?? ''

    const rspJson = {}
    rspJson.status = this.resStatuses.error
    rspJson.error = error

    res.send(JSON.stringify(rspJson))
  },

  resStatuses: Object.freeze({ ok: 'OK', error: 'Error' })
}
