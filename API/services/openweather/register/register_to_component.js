const admin = require('../../../firebase');
const messages = require('../../../errors.json');

exports.register_to_service = async function (req, res) {
    try {
        let user_ref = admin.reference.child('users');
        await user_ref.child(req.body.uid).update({
            "openweather": true
        });
        res.status(200).json({
            "data": {
                "message": "registered successfully"
            },
            "message": messages.message["200"],
            "status": "200"
        })
    } catch (error) {
        res.status(297).json({
            "data": {
                "message": error.message,
            },
            "message": messages.message["297"],
            "status": "297"
        })
    }
};

exports.unregister_to_service = async function (req, res) {
    try {
        let user_ref = admin.reference.child('users');
        await user_ref.child(req.body.uid).update({
            "openweather": false
        });
        res.status(200).json({
            "data": {
                "message": "unregistered successfully"
            },
            "message": messages.message["200"],
            "status": "200"
        })
    } catch (error) {
        res.status(297).json({
            "data": {
                "message": error.message,
            },
            "message": messages.message["297"],
            "status": "297"
        })
    }
};

exports.is_user_registered_to_service = async function (req, res) {
    try {
        let user_ref = admin.reference.child('users');
        await user_ref.child(req.body.uid).once("value", function (value) {
            res.status(200).json({
                "data": {
                    "openweather": value.val().openweather
                },
                "message": messages.message["200"],
                "status": "200"
            })
        })
    } catch (e) {
        res.status(297).json({
            "data": {
                "message": e.message,
            },
            "message": messages.message["297"],
            "status": "297"
        })
    }
}