const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const mailer = require('nodemailer');
const bcrypt = require('bcrypt');
const database = require('../database');


const pwStrength = new RegExp(/^(?=.*[A-Za-z])(?=.*\d)[\S]{6,}$/); // mindestens 6 Stellen && eine Zahl && ein Buchstabe

function createToken(id, email, username) {
    return jwt.sign({ id, email, username }, "ideaoverflow420", { expiresIn: "1y" })
}

router.post("/register", async (req, res) => {
    database.getConnection((err, con) => {

        if (!req.body.email || !req.body.username || !req.body.password1 || !req.body.password2) {
            con.release();
            return res.json({ header: "Fehler", message: 'Informationen unvollständig.' });
        } else if (!pwStrength.test(req.body.password1)) {
            con.release();
            return res.json({ header: "Fehler", message: 'Das Passwort muss mindestens 6 Zeichen lang sein. Darunter müssen mindestens ein Buchstabe und eine Zahl sein.' });
        } else if (req.body.password1 != req.body.password2) {
            con.release();
            return res.json({ header: "Fehler", message: 'Die Passwörter stimmen nicht überein.' });
        }


        con.query(`SELECT * FROM user WHERE email = ?`, [req.body.email], (err, user) => {
            if (err) {
                con.release();
                return res.status(401).json({ err })
            } else if (user[0]) {
                con.release();
                return res.json({ header: "Fehler", message: 'Dieser Benutzer existiert bereits.' })
            }

            // generate a 13 long alphanumeric verification code
            let code = "0" + Math.random().toString(36).substr(2);

            bcrypt.genSalt(512, (err, salt) => {
                bcrypt.hash(req.body.password1, salt, (err, enc) => {
                    con.query(`
                            INSERT INTO user (email, username, password, verificationcode) 
                            VALUES (${con.escape(req.body.email)}, ${con.escape(req.body.username)}, ${con.escape(enc)}, ${con.escape(code)})
                            `, (err, result) => {
                        if (err) {
                            con.release();
                            return res.status(500).json({ err });
                        }

                        con.release();
                        return res.json({ header: "Gratuliere!", message: "Der Benutzer wurde angelegt. Bitte bestätige noch deine E-Mail, sie kann auch im Spam-Ordner gelandet sein. Danach kannst du kannst dich anmelden." });
                    });
                });
            });
        })
    });
});


router.post("/login", async (req, res) => {
    database.getConnection((err, con) => {

        if (!req.body.email || !req.body.password) {
            con.release();
            return res.json({ message: "Bitte fülle alle Felder aus." });
        } else {
            con.query(`SELECT * FROM user WHERE email = ?`, [req.body.email], (err, users) => {
                if (err) {
                    con.release();
                    return res.status(404).json({ err });
                }

                if (users.length == 0) {
                    return res.json({ message: "Bist du sicher, dass du deine E-Mail richtig geschrieben hast? Diesen Benutzer gibt es nämlich nicht." });
                }

                if (users[0].verified == 1 || users[0].verified == 2) {
                    bcrypt.compare(req.body.password, users[0].pw, (err, isMatch) => {
                        if (err) {
                            return res.status(500).json({ err });
                        }
                        if (!isMatch) {
                            return res.json({ message: "Das Passwort ist falsch.", wrongpw: true });
                        } else {
                            if (users[0].verified == 2) {
                                con.query(`UPDATE user SET verified = 1, verificationcode = "" WHERE id = ` + users[0].id);
                            }



                            let usertoken = createToken(users[0].id, users[0].email, users[0].username)

                            let answer = { message: "Erfolgreich angemeldet.", token: usertoken }
                            return res.json(answer);
                        }
                    });
                } else {
                    return res.json({ message: "Du bist noch nicht verifiziert. Willst du den Verifizierungslink erneut senden?", notverified: true });
                }
            });
        }
    });
});

router.get('/daten/:id', (req, res) => {
    database.getConnection((err, con) => {
        con.query(`
            SELECT u.id, u.email, u.username
            FROM user u 
            WHERE u.id = ?
            `, [req.params.id], (err, schueler) => {
            con.release();
            if (err) {
                return res.status(500).json({ err });
            }
            else {
                if (schueler[0]) {
                    return res.send(schueler[0]);
                }
                else {
                    return res.status(500).json({ message: 'user nicht gefunden' });
                }
            }
        })
    });
});

module.exports = router