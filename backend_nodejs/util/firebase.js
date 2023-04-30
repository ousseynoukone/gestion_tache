//const firebase = require('firebase');
const { initializeApp } = require("firebase/app");
const { getFirestore } = require("firebase/firestore");

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyD2DjAYHHxcKF_IEfJ8-3Zn3aubhyex8zM",
  authDomain: "task-app-1ad42.firebaseapp.com",
  projectId: "task-app-1ad42",
  storageBucket: "task-app-1ad42.appspot.com",
  messagingSenderId: "586727540801",
  appId: "1:586727540801:web:d577588320e6e044abdec0"
};

// Initialize Firebase
let app = initializeApp(firebaseConfig);

const db = getFirestore(app);

module.exports = { db }