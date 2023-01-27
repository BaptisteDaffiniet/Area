const admin = require('../firebase');
const messages = require('../errors.json')

exports.link_account = function (req, res) {
    let current_user = admin.firebase.auth().currentUser;
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
    current_user.linkWithCredential(credentials).then(async (user) => {
        let user_ref = admin.reference.ref.child("users");
        switch (req.body.provider) {
            case "google":
                await user_ref.child(user.user.uid).update({
                    "token_google": req.body.token
                });
                break;
            case "facebook":
                await user_ref.child(user.user.uid).update({
                    "token_facebook": req.body.token
                });
                break;
            default:
                break;
        }
        res.status(200).json({
            "data": {
                "message": "account linked successfully"
            },
            "message": messages.message["200"],
            "status": "200"
        })
    }).catch((error) => {
        res.status(297).json({
            "data": {
                "message": error.message,
            },
            "message": messages.message["297"],
            "status": "297"
        })
    });
}