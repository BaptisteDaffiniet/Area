const admin = require('../../../firebase');
const messages = require('../../../errors.json');

exports.get_time_between_2_points = async function (req, res) {
    try {
        let google_map_ref = admin.reference.child("google").child("map");
        await google_map_ref.child(req.body.uid).once("value", function (value) {
            let origin = value.val().origin;
            let destination = value.val().destination;
            let url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + origin + "&destination=" + destination + "&key=" + admin.google_apikey;
            admin.axios.get(url).then((response) => {
                let json = {};
                console.log(response);
                json["distance"] = response["routes"][0]["legs"][0]["distance"]["text"];
                json["duration"] = response["routes"][0]["legs"][0]["duration"]["text"];
                json["start_address"] = response["routes"][0]["legs"][0]["start_address"];
                json["end_address"] = response["routes"][0]["legs"][0]["end_address"];
                res.status(200).json({
                    "data": json,
                    "message": messages.message["200"],
                    "status": "200"
                })
            }).catch((error) => {
                res.status(297).json({
                    "data": {
                        "message": error.message
                    },
                    "message": messages.message["297"],
                    "status": "297"
                })
            });
        })
    } catch (e) {
        res.status(297).json({
            "data": {
                "message": e.message
            },
            "message": messages.message["297"],
            "status": "297"
        })
    }
};