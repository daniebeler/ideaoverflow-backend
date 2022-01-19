const express = require('express')
const app = express()
const cors = require('cors')

const https = require('https')
const fs = require('fs')

app.use(cors())
app.use(express.json())

const userRoute = require('./routes/userRoute')
app.use('/user', userRoute)

const postRoute = require('./routes/postRoute')
app.use('/post', postRoute)

const followerRoute = require('./routes/followerRoute')
app.use('/follower', followerRoute)

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
