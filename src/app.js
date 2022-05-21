const express = require('express')
const app = express()
const cors = require('cors')

const https = require('https')
const fs = require('fs')

app.use(cors())
app.use(express.json())

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
    key: fs.readFileSync('/etc/letsencrypt/live/api.ideaoverflow.xyz/privkey.pem'),
    cert: fs.readFileSync('/etc/letsencrypt/live/api.ideaoverflow.xyz/cert.pem')
  }

  https.createServer(options, app).listen(8080)
} catch (error) {
  app.listen(6969, () => {
    console.log('Server started')
  })
}
