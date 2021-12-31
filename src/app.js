const express = require('express')
const app = express()
const cors = require('cors')

app.use(cors())
app.use(express.json())

const userRoute = require('./routes/userRoute')
app.use('/user', userRoute)

const postRoute = require('./routes/postRoute')
app.use('/post', postRoute)

app.listen(8080, () => {
  console.log('Server started')
})
