const express = require('express');
const { route } = require('express/lib/application');
const app = express();
const cors = require('cors');

app.use(cors());
app.use(express.json());

const userRoute = require('./routes/userRoute');
app.use('/user', userRoute);

route.post


app.listen(8080, () => {
    console.log("Server started");
})