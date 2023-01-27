const admin = require('../../../firebase');
const messages = require('../../../errors.json')

exports.get_currency = async function (req, res) {
    try {
        let currency_1 = req.body.currency_1;
        let currency_2 = req.body.currency_2;
        let url = "https://currencydatafeed.com/api/data.php?token=" + admin.monnaie_api_key + "&currency=" + currency_1 + "/" + currency_2;
        admin.axios.get(url).then((response) => {
            res.status(200).json({
                "data": {
                    "value": response["data"]["currency"][0]["value"],
                    "currency": response["data"]["currency"][0]["currency"]
                },
                "message": messages.message["200"],
                "status": "200"
            });
        }).catch((error) => {
            res.status(400).json({
                "data": {
                    "message": error.message
                },
                "message": messages.message["400"],
                "status": "400"
            })
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
};

exports.trigger_btc = async function (req, res) {
    try {
        let url = "https://currencydatafeed.com/api/data.php?token=" + admin.monnaie_api_key + "&currency=BTC/EUR";
        admin.axios.get(url).then((response) => {
            res.status(200).json({
                "data": {
                    "value": response.data.currency[0].value,
                    "date": response.data.currency[0].date
                },
                "message": messages.message["200"],
                "status": "200"
            });
        }).catch((error) => {
            res.status(400).json({
                "data": {
                    "message": error.message
                },
                "message": messages.message["400"],
                "status": "400"
            })
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