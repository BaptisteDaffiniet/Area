const admin = require('../../../firebase');
const messages = require('../../../errors.json');
const { default: axios } = require('axios');

exports.get_weather = async function (req, res) {
    try {
        let url = 'https://api.openweathermap.org/data/2.5/weather?q=' + req.body.city + '&lang=fr&units=metric&appid=' + admin.openweather_apikey;
        let response = await axios.get(url);
        let json = {
            "temp": response.data.main.temp,
            "desc": response.data.weather[0].description
        }
        res.status(200).json({
            "data": json,
            "message": messages.message["200"],
            "status": "200"
        });
    } catch (e) {
        res.status(297).json({
            "data": {
                "message": e.message
            },
            "message": messages.message["297"],
            "status": "297"
        })
    }
}

