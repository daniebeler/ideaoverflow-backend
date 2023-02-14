const ErrorHandler = (err, req, res, next) => {
  console.log('Middleware Error Hadnling')
  console.log(err)
  const errStatus = err.statusCode || 500
  const errMsg = 'Something went wrong'
  res.status(errStatus).json({
    success: false,
    status: errStatus,
    message: errMsg
  })
}

module.exports = ErrorHandler
