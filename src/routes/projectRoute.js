const express = require('express')
const router = express.Router()
const database = require('../database')
const passport = require('passport')

router.get('/byid/:id', (req, res) => {
  // #swagger.tags = ['Projects']

  database.getConnection((_err, con) => {
    con.query(`
      SELECT p.*, u.profileimage, u.username
      FROM project p 
      INNER JOIN user u ON p.fk_user_id = u.id
      WHERE p.id = ${con.escape(req.params.id)}
     `, (err, user) => {
      if (err) {
        con.release()
        return res.status(500).json({ err })
      } else {
        con.query(`
      SELECT s.id, s.url
      FROM project p 
      left join screenshot s on p.id = s.fk_project_id
      WHERE p.id = ${user[0].id}
     `, (err, screenshots) => {
          con.release()
          if (err) {
            return res.status(500).json({ err })
          } else {
            if (user[0]) {
              const completeResult = user[0]
              completeResult.screenshots = []
              screenshots.forEach(element => {
                if (element.url) {
                  completeResult.screenshots.push(element.url)
                }
              })
              return res.send(completeResult)
            } else {
              return res.send({ status: 204 })
            }
          }
        })
      }
    })
  })
})

router.post('/create', passport.authenticate('userAuth', { session: false }), async (req, res) => {
  // #swagger.tags = ['Projects']

  database.getConnection((_err, con) => {
    con.query(`
    INSERT INTO project (fk_user_id, title, short_description, logo, body, website, release_date)
    VALUES (
      ${con.escape(req.body.owner_id)},
      ${con.escape(req.body.title)},
      ${con.escape(req.body.short_description)},
      ${con.escape(req.body.logo)},
      ${con.escape(req.body.body)},
      ${con.escape(req.body.website)},
      ${con.escape(req.body.release_date)})
    `, (err, fief) => {
      if (err) {
        con.release()
        console.log(err)
        return res.status(500).json({ err })
      } else {
        if (req.body.screenshots.length) {
          const ins = []
          req.body.screenshots.forEach((screenshot, index) => {
            ins.push([fief.insertId, screenshot, index])
          })

          con.query(`
        INSERT INTO screenshot (fk_project_id, url, sorting_index)
        VALUES ?
          
        `, [ins], (err) => {
            con.release()
            if (err) {
              console.log(err)
              return res.status(500).json({ err })
            } else {
              return res.status(200).json({ status: 200, header: 'Nice!', message: 'Your project is now online!', id: fief.insertId })
            }
          })
        } else {
          return res.status(200).json({ status: 200, header: 'Nice!', message: 'Your project is now online!', id: fief.insertId })
        }
      }
    })
  })
})

router.post('/update', passport.authenticate('userAuth', { session: false }), async (req, res) => {
  // #swagger.tags = ['Projects']

  if (/^(http:\/\/)/.test(req.body.website)) {
    req.body.website = req.body.website.slice(7)
  } else if (/^(https:\/\/)/.test(req.body.website)) {
    req.body.website = req.body.website.slice(8)
  }

  database.getConnection((_err, con) => {
    con.query(`
    UPDATE project
    SET 
    title = ${con.escape(req.body.title)},
    body = ${con.escape(req.body.body)},
    start_date = ${con.escape(req.body.start_date)},
    release_date = ${con.escape(req.body.release_date)},
    logo = ${con.escape(req.body.logo)},
    short_description = ${con.escape(req.body.short_description)},
    website = ${con.escape(req.body.website)}
    WHERE id = ${con.escape(req.body.id)}`, (err) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.json({ status: 200, header: 'Nice!', message: 'Your project has been updated!', id: -1 }).send()
      }
    })
  })
})

router.post('/projects', (req, res) => {
  // #swagger.tags = ['Projects']

  let usernameFilter = ''
  let order = 'ORDER BY coalesce(p.release_date, p.creation_date) DESC'

  if (req.body.username) {
    usernameFilter = 'WHERE u.username = "' + req.body.username + '"'
  }

  if (req.body.sortingCriteria === 'newest') {
    order = 'ORDER BY coalesce(p.release_date, p.creation_date) DESC'
  } else if (req.body.sortingCriteria === 'oldest') {
    order = 'ORDER BY coalesce(p.release_date, p.creation_date) ASC'
  }

  database.getConnection((_err, con) => {
    con.query(`
      SELECT p.*, u.profileimage, u.color, u.username
      FROM project p
      INNER JOIN user u ON p.fk_user_id = u.id
      ${usernameFilter}
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

router.get('/numberoftotalprojects', (req, res) => {
  // #swagger.tags = ['Projects']

  database.getConnection((_err, con) => {
    con.query('SELECT count(id) as numberoftotalprojects FROM project', (err, result) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        return res.send(result[0])
      }
    })
  })
})

router.get('/checkifprojectbelongstouser/:projectid', passport.authenticate('userAuth', { session: false }), (req, res) => {
  // #swagger.tags = ['Projects']

  database.getConnection((_err, con) => {
    con.query(`
      SELECT *
      FROM project
      WHERE id = ${con.escape(req.params.projectid)}
     `, (err, post) => {
      con.release()
      if (err) {
        return res.status(500).json({ err })
      } else {
        if (post[0] && post[0].fk_user_id === req.user.id) {
          return res.send({ accessgranted: true })
        } else {
          return res.send({ accessgranted: false })
        }
      }
    })
  })
})

module.exports = router
