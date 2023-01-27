const admin = require('../../../firebase');
const messages = require('../../../errors.json');

exports.send_tweet = async function(req, res) {
    var Twitter = require('twitter');

    var client = new Twitter({
        consumer_key: admin.twitter_apikey.consumer_key,
        consumer_secret: admin.twitter_apikey.consumer_secret,
        access_token_key: admin.twitter_apikey.access_token_key,
        access_token_secret: admin.twitter_apikey.access_token_secret
    });

    await client.post('statuses/update', {status: req.body.statuses})
        .then(function (tweet) {
            res.status(200).json({
                "data": {
                    "message": "tweet successfully sended"
                },
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
};