const messages = require('../../../errors.json');
const admin = require('../../../firebase');
const mail = require('nodemailer');

exports.send_email = async function (req, res) {
    try {
        let user_ref = admin.reference.child('users');
        let transport = mail.createTransport({
            service: 'gmail',
            auth: {
                user: "registerdashboard@gmail.com",
                pass: "SYUk8EPG68eKKr8"
            }
        });
        let options = {
            from: "registerdashboard@gmail.com",
            to: req.body.receiver,
            subject: req.body.subject,
            text: req.body.text_content
        };
        await transport.sendMail(options, function (error) {
            let status = "400";
            return res.status(status).json({
                "data": {
                    'message': error.message
                },
                "message": messages.message[status],
                'status': status
            });
        });
        res.status(200).json({
            "data": {
                "message": "email sended successfully"
            },
            "message": messages.message["200"],
            "status": "200"
        })
    } catch (e) {
        console.error(e);
        status = "400";
        return res.status(status).json({
            "data": {
                'message': e.message
            },
            "message": messages.message[status],
            'status': status
        });
    }
}