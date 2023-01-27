const messages = require('../errors.json');
const admin = require('../firebase');
const mail = require('nodemailer');

exports.create_user = async function (req, res) {
    try {
        await admin.admin.auth().createUser({
            email: req.body.email,
            displayName: req.body.username,
            emailVerified: false,
            password: req.body.password,
            disabled: true,
        }).then(async (userRecord) => {
            status = "201";
            admin.admin.auth().createCustomToken(userRecord.uid).then(async (token) => {
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
                    to: userRecord.email,
                    subject: 'email confirmation',
                    text: "hi, please confirm your email address by clicking on this link\n" +
                        "http://localhost:8080/api/users/activate?uid=" + userRecord.uid
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
                let json = {};
                json["email"] = userRecord.email;
                json["displayName"] = userRecord.displayName;
                json["token"] = token;
                json["token_google"] = "";
                json["token_facebook"] = "";
                json["roles"] = ["role_user"];
                json['conversion_monnaie'] = false;
                json['facebook'] = false;
                json['google'] = false;
                json['instagram'] = false;
                json["office"] = false;
                json["twitter"] = false;
                json["youtube"] = false;
                await user_ref.child(userRecord.uid).set(json);
                res.status(status).json({
                    "data": {
                        "uid": userRecord.uid,
                        "email": userRecord.email,
                        "displayName": userRecord.displayName,
                        "token": token,
                        "token_google": "",
                        "token_facebook": "",
                        "roles": ["role_user"],
                        'conversion_monnaie': false,
                        'facebook': false,
                        'google': false,
                        'instagram': false,
                        "office": false,
                        "twitter": false,
                        "youtube": false
                    },
                    "message": messages.message[status],
                    "status": status
                });
                console.log("user created: ", userRecord.uid)
            })
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
};

exports.create_user_with_google = function (req, res) {

}