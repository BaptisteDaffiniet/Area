const express = require('express')
const request_ip = require('request-ip')
usercreation = require('./User/create_user')
get_user = require('./User/get_users')
update_user = require('./User/update_user')
connect_user = require('./User/connect_user')

conversion_monnaie = require('./services/convertisseur_monnaie/register/register_to_component')
action_currency = require('./services/convertisseur_monnaie/action/get_currency')

facebook = require('./services/facebook/register/register_to_component')

google = require('./services/google/register/register_to_component')
google_maps = require('./services/google/action/google_maps_2_towns')

instagram = require('./services/instagram/register/register_to_component')

office = require('./services/office/register/register_to_component')

twitter = require('./services/twitter/register/register_to_component')
twitter_send = require('./services/twitter/action/send_tweet')
twitter_get = require('./services/twitter/action/get_last_tweets')

//twitch = require('./services/twitch/register/register_to_component')
//twitch_notif = require('./services/twitch/reaction/get_twitch_notif')

youtube = require('./services/youtube/register/register_to_component')

openweather = require('./services/openweather/register/register_to_component')
openweather_weather = require('./services/openweather/action/get_weather')

const app = express()
app.use(express.json())

// User part //

app.post('/api/create_user', usercreation.create_user);
app.get('/api/user', get_user.get_user);
app.post('/api/connection', connect_user.connect_user);
app.get('/api/connection_credentials', connect_user.connect_user_with_credentials);
app.get('/api/disconnect', connect_user.disconnect_user);
app.get('/api/users/reset_password', update_user.reset_password);
app.get('/api/users/update_username', update_user.update_username);
app.get('/api/users/update_mail', update_user.update_mail);
app.get('/api/users/activate', update_user.update_activation);

// END User part //


// Services part //

// conversion part //
app.post('/api/register_conversion', conversion_monnaie.register_to_service);
app.post('/api/unregister_conversion', conversion_monnaie.unresgister_to_service);
app.post('/api/is_user_registered_conversion', conversion_monnaie.is_user_registered_to_service);
app.get('/api/register_action_currency', conversion_monnaie.register_to_action_get_currency);
app.get('/api/unregister_action_currency', conversion_monnaie.unregister_to_action_get_currency);
app.post('/api/get_action_currency', action_currency.get_currency);
app.post('/api/trigger_btc', action_currency.trigger_btc);
// END conversion part /

// Facebook part //
app.post('/api/register_facebook', facebook.register_to_service);
app.post('/api/unregister_facebook', facebook.unresgister_to_service);
app.post('/api/is_user_registered_facebook', facebook.is_user_registered_to_service);
// END Facebook part //

// google part //
app.post('/api/register_google', google.register_to_service);
app.post('/api/unregister_google', google.unresgister_to_service);
app.post('/api/is_user_registered_google', google.is_user_registered_to_service);
app.get('/api/register_action_get_info_between_2_towns', google.register_to_action_get_info_between_2_towns);
app.get('/api/unregister_action_get_info_between_2_towns', google.unregister_to_action_get_info_between_2_towns);
app.get('/api/get_info_between_2_towns', google_maps.get_time_between_2_points);
// END google part //

// instagram part //
app.post('/api/register_instagram', instagram.register_to_service);
app.post('/api/unregister_instagram', instagram.unresgister_to_service);
app.post('/api/is_user_registered_instagram', instagram.is_user_registered_to_service);
// END instagram part //

// office part //
app.post('/api/register_office', office.register_to_service);
app.post('/api/unregister_office', office.unresgister_to_service);
app.post('/api/is_user_registered_office', office.is_user_registered_to_service);
// END office part //

// twitter part //
app.post('/api/register_twitter', twitter.register_to_service);
app.post('/api/unregister_twitter', twitter.unresgister_to_service);
app.post('/api/is_user_registered_twitter', twitter.is_user_registered_to_service);
app.post('/api/send_tweet', twitter_send.send_tweet);
app.post('/api/get_last_user_tweet', twitter_get.get_last_user_tweet);
// END twitter part //

// twitch part //
/*app.get('/api/register_twitch', twitch.register_to_service);
app.get('/api/unregister_twitch', twitch.unresgister_to_service);
app.post('/api/is_user_registered_twitch', twitch.is_user_registered_to_service);
app.get('/api/get_twitch_notif', twitch_notif.get_twitch_notification)*/
// END twitch part //

// youtube part //
app.post('/api/register_youtube', youtube.register_to_service);
app.post('/api/unregister_youtube', youtube.unresgister_to_service);
app.post('/api/is_user_registered_youtube', youtube.is_user_registered_to_service);
// END youtube part //

// openweather part //
app.post('/api/register_openweather', openweather.register_to_service);
app.post('/api/unregister_openweather', openweather.unregister_to_service);
app.post('/api/is_user_registered_openweather', openweather.is_user_registered_to_service);
app.post('/api/get_weather', openweather_weather.get_weather);
// END openweather part //

// END Services part //


// about.json part //

app.get('/about.json', function (req, res) {
    let ip_address = request_ip.getClientIp(req);
    res.status(200).json({
        "client": {
            "host": ip_address
        },
        "server": {
            "current_time": Math.floor(+new Date() / 1000),
            "services": [{
                "name": "gmail",
                "actions": [{
                    "name": "sending_mail",
                    "description": "The user send a mail to one or multiple receiver",
                }],
            }, {
                "name": "twitter",
                "actions": [{
                    "name": "sending_tweet",
                    "description": "The user post a new tweet on his account",
                }],
                "reactions": [{
                    "name": "receiving_last_tweet",
                    "desciption": "The user see his 10 last tweet",
                }]
            }, {
                "name": "mail",
                "reactions": [{
                    "name": "receiving_mail",
                    "description": "The user receive a notification when a new mail drop in his inbox",
                }]
            }
        ]
        }
    })
})

// END about.json part //

app.listen(8080, function () {
    console.log("server is listening on 8080")
})