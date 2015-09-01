/**
 * Created by tbbates on 1/20/15.
 */
'use strict';
module.exports = function () {
    var nodemailer = require('nodemailer'),
    smtpTransport = require('nodemailer-smtp-transport');

    function sendHtmlEmail(app, from, to, subject, body) {
        var transport = nodemailer.createTransport(smtpTransport({
            host: app.config.smtp.server,
            port: app.config.smtp.port,
            auth: {
                user: app.config.smtp.username,
                pass: app.config.smtp.password
            },
            secure:false,
            debug:true,
            tls: {rejectUnauthorized: false}

        }));
        var mailOptions = {
            from: from,
            to: to,
            subject: subject,
            html: body
        };

        transport.sendMail(mailOptions, function (error, response) {
            if (error) {
                console.log(error);
            } else {
                console.log('Message sent: ' + response.message);
            }
        });

    }

    function sendTextEmail(app, from, to, subject, text) {
        var transport = nodemailer.createTransport(smtpTransport({
            host: app.config.smtp.server,
            port: app.config.smtp.port,
            auth: {
                user: app.config.smtp.username,
                pass: app.config.smtp.password
            },
            secure:false,
            debug:true,
            tls: {rejectUnauthorized: false}
        }));

        var mailOptions = {
            from: from,
            to: to,
            subject: subject,
            text: text
        };

        transport.sendMail(mailOptions, function (error, response) {
            if (error) {
                console.log(error);
            } else {
                console.log('Message sent: ' + response.message);
            }
        });

        
    }

    return {
        SendHtmlEmail: sendHtmlEmail,
        SendTextEmail: sendTextEmail
    };
};