const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const mailer = require('nodemailer');
const bcrypt = require('bcrypt');
const database = require('../database');


router.get('/daten/:id', (req, res) => {
    database.getConnection((err, con) => {
        con.query(`
            SELECT u.id, s.id as schueler_id, l.id as lieferant_id, u.email, s.vorname, s.nachname, s.admin, s.fk_schule_id, l.name, l.adresse 
            FROM user u 
            left join schueler s on s.fk_user_id = u.id
            left join lieferant l on l.fk_user_id = u.id 
            WHERE u.id = ?
            `, [req.params.id], (err, schueler) => {
            con.release();
            if (err) {
                return res.status(500).json({ err });
            }
            else {
                if (schueler[0].schueler_id) {
                    schueler[0].role = 'schueler';
                }
                else if (schueler[0].lieferant_id) {
                    schueler[0].role = 'lieferant';
                }
                else {
                    return res.status(500).json({message: 'user nicht gefunden'});
                }
                return res.send(schueler[0]);
            }
        })
    });
});

module.exports = router