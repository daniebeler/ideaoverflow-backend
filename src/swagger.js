const swaggerAutogen = require('swagger-autogen')()
require('dotenv').config()

const doc = {
  info: {
    title: 'Idea Overflow API',
    description: 'API for Idea Overflow'
  },
  host: process.env.HOST,
  schemes: ['http', 'https'],
  consumes: ['application/json'],
  produces: ['application/json'],
  securityDefinitions: {
    Bearer: {
      type: 'apiKey',
      name: 'Authorization',
      in: 'header'
    }
  }
}

const outputFile = '../swagger-output.json'
const endpointsFiles = ['./src/app.js']

swaggerAutogen(outputFile, endpointsFiles, doc)
