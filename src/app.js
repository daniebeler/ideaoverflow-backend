const ErrorHandler = require('./middleware/errorHandler.js')
const express = require('express')
const app = express()
const cors = require('cors')

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

app.use(ErrorHandler)

app.listen(3003, () => {
  console.log('Server started using http on port 3003')
})
