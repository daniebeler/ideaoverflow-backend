const ErrorHandler = require('./middleware/errorHandler.js')
const express = require('express')
const app = express()
const cors = require('cors')

const swaggerUi = require('swagger-ui-express')
const swaggerFile = require('../swagger-output.json')

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

const commentRoute = require('./routes/commentRoute')
app.use('/comment', commentRoute)

app.use(ErrorHandler)
app.use('/doc', swaggerUi.serve, swaggerUi.setup(swaggerFile))

app.listen(3003, () => {
  console.log('Server started using http on port 3003')
})
