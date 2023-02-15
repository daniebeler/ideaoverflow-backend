/* eslint-disable camelcase */
const express = require('express')
const router = express.Router()
const database = require('../database')
const passport = require('passport')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const helper = require('../helper')

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.get('/byid/:id', use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const ideaId = parseInt(req.params.id)
  const result = await prisma.post.findUnique({
    where: {
      id: ideaId
    },
    include: {
      user: {
        select: {
          id: true,
          username: true,
          firstname: true,
          lastname: true,
          profileimage: true,
          color: true
        }
      }
    }
  })

  if (result) {
    return res.send(result)
  } else {
    return res.send({ status: 204 })
  }
}))

router.get('/byusername/:username', use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  console.log(req.query)
  const query = helper.convertQuery(req.query)
  const result = await prisma.post.findMany({
    skip: query.skip ?? 0,
    take: query.take ?? 100,
    orderBy: {
      creation_date: query.orderDirection
    },
    where: {
      user: {
        username: req.params.username
      }
    },
    include: {
      user: {
        select: {
          id: true,
          username: true,
          firstname: true,
          lastname: true,
          profileimage: true,
          color: true
        }
      }
    }
  })

  if (result) {
    return res.send(result)
  } else {
    return res.send({ status: 204 })
  }
}))

router.get('/all', use(async (req, res) => {
  // #swagger.tags = ['Ideas']

  const query = helper.convertQuery(req.query)
  const result = await prisma.post.findMany({
    skip: query.skip ?? 0,
    take: query.take ?? 100,
    orderBy: {
      creation_date: query.orderDirection
    },
    include: {
      user: {
        select: {
          id: true,
          username: true,
          firstname: true,
          lastname: true,
          profileimage: true,
          color: true
        }
      }
    }
  })

  if (result) {
    return res.send(result)
  } else {
    return res.send({ status: 204 })
  }
}))

router.post('/create', passport.authenticate('userAuth', { session: false }), async (req, res) => {
  // #swagger.tags = ['Ideas']

  database.dbInsert('INSERT INTO post (fk_owner_user_id, title, body) VALUES (?, ?, ?)',
    [req.body.userID, req.body.header, req.body.body],
    (result, err) => {
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send({ status: 200, header: 'Nice!', message: 'Your idea is now online!' })
      }
    })
})

router.post('/update', passport.authenticate('userAuth', { session: false }), async (req, res) => {
  // #swagger.tags = ['Ideas']

  database.dbQuery('UPDATE post SET title = ?, body = ? WHERE id = ?',
    [req.body.title, req.body.body, req.body.postId],
    (result, err) => {
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send({ status: 200, header: 'Nice!', message: 'Your idea has been updated!' })
      }
    })
})

router.get('/numberoftotalideas', async (req, res) => {
  // #swagger.tags = ['Ideas']

  const numberoftotalideas = await prisma.post.count()
  return res.send({ numberoftotalideas })
})

router.post('/ideas', (req, res) => {
  // #swagger.tags = ['Ideas']

  let userIsLoggedInSelect = ''
  let userIsLoggedInJoin = ''
  let usernameFilter = ''
  let searchFilter = ''
  let savedFilter = ''
  let order = 'ORDER BY p.creation_date DESC'

  if (req.body.currentUserId) {
    userIsLoggedInSelect = 'usp.post_id as saved, vv.value as votevalue,'
    userIsLoggedInJoin = 'LEFT JOIN (SELECT * FROM vote WHERE user_id = ' + req.body.currentUserId + ') vv ON p.id = vv.post_id LEFT JOIN (SELECT * FROM user_saves_post WHERE user_id = + ' + req.body.currentUserId + ') usp ON p.id = usp.post_id'
  }

  if (req.body.username) {
    usernameFilter = 'WHERE u.username = "' + req.body.username + '"'
  }

  if (req.body.searchTerm) {
    searchFilter = 'WHERE u.username LIKE "%' + req.body.searchTerm + '%"'
  }

  if (req.body.savedByUsername) {
    savedFilter = 'INNER JOIN user_saves_post s ON s.post_id = p.id WHERE s.user_id = ' + req.body.currentUserId
    order = 'ORDER BY s.savedAt DESC'
  } else if (req.body.sortingCriteria === 'newest') {
    order = 'ORDER BY p.creation_date DESC'
  } else if (req.body.sortingCriteria === 'likes') {
    order = 'ORDER BY upvotes DESC'
  } else if (req.body.sortingCriteria === 'oldest') {
    order = 'ORDER BY p.creation_date ASC'
  }

  database.getConnection((_err, con) => {
    con.query(`
      SELECT p.*, u.id as ownerid, u.profileimage, u.color, u.username, ${userIsLoggedInSelect} (SELECT count(post_id) FROM vote vvv WHERE vvv.post_id = p.id AND vvv.value = 1) as upvotes, (SELECT count(post_id) FROM vote vvv WHERE vvv.post_id = p.id AND vvv.value = -1) as downvotes
      FROM post p
      INNER JOIN user u ON p.fk_owner_user_id = u.id
      ${userIsLoggedInJoin}
      ${savedFilter}
      ${usernameFilter}
      ${searchFilter}
      GROUP BY p.id 
      ${order} 
      limit ${req.body.take} 
      offset ${req.body.skip}`, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
  })
})

router.post('/vote', passport.authenticate('userAuth', { session: false }), (req, res) => {
  // #swagger.tags = ['Ideas']

  database.getConnection((_err, con) => {
    con.query(`
      INSERT INTO vote (user_id, post_id, value)
      VALUES(${req.body.userId}, ${req.body.ideaId}, ${req.body.voteValue})
      ON DUPLICATE KEY UPDATE value = ${req.body.voteValue}
      `, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
  })
})

router.post('/save', passport.authenticate('userAuth', { session: false }), (req, res) => {
  // #swagger.tags = ['Ideas']

  database.getConnection((_err, con) => {
    con.query(`
      INSERT IGNORE INTO user_saves_post (user_id, post_id)
      VALUES(${req.body.userId}, ${req.body.ideaId})
      `, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
  })
})

router.post('/unsave', passport.authenticate('userAuth', { session: false }), (req, res) => {
  // #swagger.tags = ['Ideas']

  database.getConnection((_err, con) => {
    con.query(`
      DELETE FROM user_saves_post WHERE user_id = ${req.body.userId} AND post_id = ${req.body.ideaId}
      `, (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result)
      }
    })
  })
})

router.get('/checkifideabelongstouser/:postid', passport.authenticate('userAuth', { session: false }), (req, res) => {
  // #swagger.tags = ['Ideas']

  database.getConnection((_err, con) => {
    con.query(`
      SELECT *
      FROM post
      WHERE id = ${con.escape(req.params.postid)}
     `, (err, post) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (post[0] && post[0].fk_owner_user_id === req.user.id) {
          return res.send({ accessgranted: true })
        } else {
          return res.send({ accessgranted: false })
        }
      }
    })
  })
})

module.exports = router
