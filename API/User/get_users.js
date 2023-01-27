const admin = require('../firebase');
const messages = require('../errors.json')

exports.get_user = async function (req, res) {
    try {
        let user = admin.firebase.auth().currentUser;
        let user_ref = admin.reference.ref.child("users");
        await user_ref.child(user.uid).once('value', function (value) {
            let json = {};
            json["uid"] = user.uid;
            json['email'] = user.email;
            json['emailVerified'] = user.emailVerified;
            json['displayName'] = user.displayName;
            json['token'] = value.val().token;
            json['token_google'] = value.val().token_google;
            json['token_facebook'] = value.val().token_facebook;
            json['roles'] = value.val().roles;
            res.status(200).json({
                "data": json,
                "message": messages.message[200],
                "status": "200"
            })
        });
    }
    catch (e) {
        res.status(298).json({
            'data': {
                "message": e.message
            },
            "message": messages.message['298'],
            "status": "298"
        })
    }
};