const admin = require('../../../firebase');
const messages = require('../../../errors.json');

// don't forget to fill up the response json part to send back data catched by user from twitter
exports.get_10_last_tweets = async function (req, res) {
    try {
        let twetter_ref = admin.reference.child("twitter").child("last_tweets");
        await twetter_ref.child(req.body.uid).once("value", function (value) {
            let url = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + req.body.name + "&count=10";
            axios.get(url).then((response) => {
                console.log(response);
                let json = {};
                res.status(200).json({
                    "data": json,
                    "message": messages.message["200"],
                    "status": "200"
                });
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

exports.get_last_user_tweet = async function (req, res) {
    var Twitter = require('twitter');

    var client = new Twitter({
        consumer_key: admin.twitter_apikey.consumer_key,
        consumer_secret: admin.twitter_apikey.consumer_secret,
        access_token_key: admin.twitter_apikey.access_token_key,
        access_token_secret: admin.twitter_apikey.access_token_secret
    });
    let param = {
        q: '@' + req.body.username,
        count: '10',
        result_type: 'recent'
    }
    await client.get('search/tweets', param)
        .then(function (tweets) {
            var json = {
                statuses: []
            }
            for (var i = 0; i < tweets.statuses.length; i++) {
                json.statuses.push(tweets.statuses[i].text);
            }
            res.status(200).json({
                "data": json,
                "message": messages.message["200"],
                "status": "200"
            });
        })
        .catch(function (error) {
            res.status(297).json({
                "data": {
                    "message": error.message
                },
                "message": messages.message["297"],
                "status": "297"
            })
        })
}