const admin = require('../../../firebase');
const message = require('../../../errors.json');

// vérifier que le userid est pas ce qui est get et stocker qaund on link des users entre eux
exports.send_mail = async function (req, res) {
    try {
        const email = `From: ${req.body.sender}\r\n`
            + `To: ${req.body.receiver}\r\n`
            + `Subject: ${req.body.subject}\r\n\r\n`
            + req.body.message
        admin.axios.post(`https://www.googleapis.com/upload/gmail/v1/users/${req.body.userId}/messages/send`, email, {
            "headers": {
                'Content-Type': 'message/rfc822',
                'Authorization': admin.google_apikey
            }
        }).then((response) => {
            res.status(200).json({
                "data": {
                    "message": "mail successfully sended"
                },
                "message": messages.message["200"],
                "status": "200"
            });
        }).catch((error) => {
            res.status(297).json({
                "data": {
                    "message": error.message
                },
                "message": message.message["297"],
                "status": 297
            })
        });
    } catch (e) {
        res.status(297).json({
            "data": {
                "message": e.message
            },
            "message": message.message["297"],
            "status": 297
        })
    }
}