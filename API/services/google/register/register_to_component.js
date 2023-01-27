const admin = require('../../../firebase');
const messages = require('../../../errors.json')

exports.register_to_service = async function (req, res) {
    try {
        let user_ref = admin.reference.child('users');
        await user_ref.child(req.body.uid).update({
            "google": true
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

exports.unresgister_to_service = async function (req, res) {
    try {
        let user_ref = admin.reference.child('users');
        await user_ref.child(req.body.uid).update({
            "google": false
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
                    "google": value.val().google
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
};

exports.register_to_action_get_info_between_2_towns = async function (req, res) {
    try {
        let conversion_ref = admin.reference.child("google").child("map");
        let json_response = {
            "origin": req.body.origin,
            "destination": req.body.destination,
        };
        await conversion_ref.child(req.body.uid).set(json_response);
        res.status(200).json({
            "data": {
                "message": "register successfully",
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

exports.unregister_to_action_get_info_between_2_towns = async function (req, res) {
    try {
        let conversion_ref = admin.reference.child("google").child("map");
        await conversion_ref.child(req.body.uid).remove();
        res.status(200).json({
            "data": {
                "message": "unregistered successfully"
            },
            "message": messages.message["200"],
            "status": "200"
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