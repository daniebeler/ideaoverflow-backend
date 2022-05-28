const express = require('express')
const app = express()
const cors = require('cors')
const https = require('https')
const fs = require('fs')
const passport = require('passport')

app.use(cors())
app.use(express.json())
app.use(passport.initialize())

const userAuth = require('./middleware/userAuth')
passport.use('userAuth', userAuth)

const registrationRoute = require('./routes/registrationRoute')
app.use('/registration', registrationRoute)

const userRoute = require('./routes/userRoute')
app.use('/user', userRoute)

const ideaRoute = require('./routes/ideaRoute')
app.use('/idea', ideaRoute)

const followerRoute = require('./routes/followerRoute')
app.use('/follower', followerRoute)

const projectRoute = require('./routes/projectRoute')
app.use('/project', projectRoute)

try {
  const options = {
    key: fs.readFileSync('/app/cert/privkey.pem'),
    cert: fs.readFileSync('/app/cert/cert.pem')
  }

  https.createServer(options, app).listen(8080)
  console.log('Server started using https on port 8080')
} catch (error) {
  app.listen(6969, () => {
    console.log('Server started using http on port 6969')
  })
}
