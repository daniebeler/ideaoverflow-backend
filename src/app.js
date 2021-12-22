const express = require('express');
const { route } = require('express/lib/application');
const app = express();

const userRoute = require('./routes/userRoute');
app.use('/user', userRoute);

route.post


app.listen(8080, () => {
    console.log("Server started");
})