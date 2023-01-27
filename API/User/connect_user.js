const admin = require('../firebase')
const message = require('../errors.json')

exports.connect_user = function (req, res) {
    console.log(req.body.email)
    console.log(req.body.password)
    admin.firebase.auth().signInWithCustomToken(req.body.token_sended).then(async (user) => {
        let user_ref = admin.reference.ref.child('users');
        await user_ref.child(user.user.uid).once('value', function (value) {
            res.status(223).json({
                "data": {
                    'uid': user.user.uid,
                    'email': user.user.email,
                    'token': req.body.token_sended,
                    'roles': value.val().roles,
                    'token_google': value.val().token_google,
                    'token_facebook': value.val().token_facebook
                },
                "message": message.message["223"],
                "status": "223"
            })
            console.log("user connected from token");
        })
    }).catch((error) => {
        admin.firebase.auth().signInWithEmailAndPassword(req.body.email, req.body.password).then((user) => {
            admin.admin.auth().createCustomToken(user.user.uid).then(async (token) => {
                let user_ref = admin.reference.ref.child("users");
                await user_ref.child(user.user.uid).update({
                    "token": token
                })
                await user_ref.child(user.user.uid).once('value', function (value) {
                    res.status(223).json({
                        'data': {
                            'uid': user.user.uid,
                            'email': user.user.email,
                            'token': token,
                            'roles': value.val().roles,
                            'token_google': value.val().token_google,
                            'token_facebook': value.val().token_facebook
                        },
                        "message": message.message["223"],
                        "status": "223"
                    })
                })
            });
        }).catch((error) => {
            console.log(error);
            res.status(299).json({
                "data":
                    {
                        "message": "authentication failed"
                    },
                "message": message.message["299"],
                "status": "299"
            });
        });
    });
}

exports.disconnect_user = function (req, res) {
    admin.firebase.auth().signOut().then(() => {
        console.log("user disconnected");
        res.status(200).json({
            "data": {
                "message": "user disconnected successfully"
            },
            "message": message.message["200"],
            "status": "200"
        })
    }).catch((error) => {
        console.log(error);
        res.status(400).json({
            "data": {
                "message": error.message
            },
            "message": message.message["400"],
            "status": "400"
        })
    });
}

exports.connect_user_with_credentials = async function (req, res) {
    let credentials;
    switch (req.body.provider) {
        case "google":
            credentials = admin.firebase.auth.GoogleAuthProvider.credential(req.body.token);
            break;
        case "facebook":
            credentials = admin.firebase.auth.FacebookAuthProvider.credential(req.body.token);
            break;
        default:
            credentials = null;
            break;
    }
    admin.firebase.auth().signInWithCredential(credentials).then((user) => {
        admin.admin.auth().createCustomToken(user.user.uid).then(async (token) => {
            let user_ref = admin.reference.ref.child("users");
            await user_ref.child(user.user.uid).update({
                "token": token
            })
            await user_ref.child(user.user.uid).once('value', function (value) {
                res.status(223).json({
                    'data': {
                        'uid': user.user.uid,
                        'email': user.user.email,
                        'token': token,
                        'roles': value.val().roles,
                        'token_google': value.val().token_google,
                        'token_facebook': value.val().token_facebook
                    },
                    "message": message.message["223"],
                    "status": "223"
                })
            })
        });
    }).catch((error) => {
        console.log(error);
        res.status(299).json({
            "data":
                {
                    "message": "authentication failed"
                },
            "message": message.message["299"],
            "status": "299"
        });
    })
}