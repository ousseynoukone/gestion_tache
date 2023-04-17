//const firebase = require('firebase');
const { initializeApp } = require("firebase/app");
const { getFirestore } = require("firebase/firestore");

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAPKy7F8xZ5ZVuREIJRhAArcOJB3cOQ7Eg",
  authDomain: "flutter-gestion-tache-firebase.firebaseapp.com",
  projectId: "flutter-gestion-tache-firebase",
  storageBucket: "flutter-gestion-tache-firebase.appspot.com",
  messagingSenderId: "965723048235",
  appId: "1:965723048235:web:92d628aeeb4f758ef61d6e"
};

// Initialize Firebase
let app = initializeApp(firebaseConfig);

const db = getFirestore(app);

module.exports = { db }