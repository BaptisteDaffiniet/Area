const firebase = require('../firebase');
const messages = require('../errors.json')

exports.reset_password = async function (req, res) {
    await firebase.admin.auth().updateUser(req.body.uid, {
        password: req.body.password,
    }).then((user) => {
        res.status(200).json({
            "data": {
                "password": req.body.password
            },
            "message": messages.message["200"],
            "status": "200"
        });
        console.log("user updated");
    }).catch((error) => {
        console.error(error.message);
        res.status(297).json({
            "data": {
                "message": "cannot update password"
            },
            "message": messages.message['297'],
            'status': "297"
        })
    })
};

exports.update_username = async function (req, res) {
    await firebase.admin.auth().updateUser(req.body.uid, {
        displayName: req.body.username,
    }).then(async (user) => {
        let user_ref = firebase.reference.child('users');
        await user_ref.child(user.uid).update({
            "username": req.body.displayName
        })
        res.status(200).json({
            "data": {
                'username': req.body.displayName
            },
            "message": messages.message["200"],
            "status": "200"
        });
        console.log("user updated");
    }).catch((error) => {
        console.error(error.message);
        res.status(297).json({
            "data": {
                "message": 'cannot update username'
            },
            "message": messages.message['297'],
            'status': "297"
        })
    })
};

exports.update_mail = async function (req, res) {
    await firebase.admin.auth().updateUser(req.body.uid, {
        email: req.body.email,
        disabled: true,
        emailVerified: false
    }).then(async (user) => {
        let user_ref = firebase.reference.child('users');
        await user_ref.child(user.uid).update({
            "email": req.body.email
        })
        res.status(200).json({
            "data": {
                'email': req.body.email
            },
            "message": messages.message["200"],
            "status": "200"
        });
        console.log("user updated");
    }).catch((error) => {
        console.error(error.message);
        res.status(297).json({
            "data": {
                "message": "cannot update mail"
            },
            "message": messages.message['297'],
            'status': "297"
        })
    })
};

exports.update_activation = async function (req, res) {
    console.log(req.query.uid);
    await firebase.admin.auth().updateUser(req.query.uid, {
        disabled: false,
        emailVerified: true
    }).then((user) => {
        res.status(200).json({
            "data": {},
            "message": messages.message["200"],
            "status": "200"
        });
        console.log("user updated");
    }).catch((error) => {
        console.error(error.message);
        res.status(297).json({
            "data": {
                "message": "cannot activate account"
            },
            "message": messages.message['297'],
            'status': "297"
        })
    })
};