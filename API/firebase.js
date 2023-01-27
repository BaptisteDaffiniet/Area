const admin = require("firebase-admin");
const firebase = require('firebase');
const axios = require('axios');

const conversion_monnaie_apikey = "diy3l92ux1uzm0cgrnm6";
const google_apikey = "AIzaSyCIPaj2veC33mEKxouX3PNeIraoIh8gA-8";
const openweather_apikey = '04e4855a6e02cfafa37f5c018bdfcd5c';
const twitch_apikey = {
    client_id: 'algiqpvidjdtsmrsicn0d922xoyf0p',
    client_secret: 'v3tr1rthcsgfw54mx6kn9ll2531nvn'
};
const twitter_apikey = {
    consumer_key: 'mLDWwtZEv5j7Jl9YcxdiS9qmW',
    consumer_secret: 'fMZ6GTBjL9N7zyQG70UTMVKivIWPN2TVUR2srrai8gyJEmjn2E',
    access_token_key: '1235577338827505664-FaCVfFLvBEaJqjVVE6HAZnskr1nY4H',
    access_token_secret: '8EeXzc0vJBIYoif4r1uvX9vAsCLauqqXhl7Wa4z7lwV9q'
};

const firebaseConfig = {
    apiKey: "AIzaSyAG2065TseplYUeQ-h_Z3nadbCmT0ajwVI",
    authDomain: "area-64e17.firebaseapp.com",
    databaseURL: "https://area-64e17-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "area-64e17",
    storageBucket: "area-64e17.appspot.com",
    messagingSenderId: "54184270803",
    appId: "1:54184270803:web:4894dfd10ebfe711fdad26"
};
const serviceAccount = require("./area-64e17-firebase-adminsdk-unlyg-dc8a6729a8.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://area-64e17-default-rtdb.europe-west1.firebasedatabase.app"
});

firebase.initializeApp(firebaseConfig);

const database = admin.firestore();

const google_auth_provider = new firebase.auth.GoogleAuthProvider();

const facebook_auth_provider = new firebase.auth.FacebookAuthProvider();

firebase.auth().useDeviceLanguage();

let reference = admin.database().ref("/");

exports.admin = admin;
exports.database = database;
exports.firebase = firebase;
exports.google_provider = google_auth_provider;
exports.facebook_provider = facebook_auth_provider;
exports.reference = reference;
exports.monnaie_api_key = conversion_monnaie_apikey;
exports.twitter_apikey = twitter_apikey;
exports.twitch_apikey = twitch_apikey;
exports.google_apikey = google_apikey;
exports.openweather_apikey = openweather_apikey;
exports.axios = axios;