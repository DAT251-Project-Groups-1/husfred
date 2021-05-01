importScripts("https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js");

var firebaseConfig = {
  apiKey: "AIzaSyA5ArYmOPtp4W6WzR66I6mi-Xt4UlsoMvM",
  authDomain: "husfred-b5e27.firebaseapp.com",
  projectId: "husfred-b5e27",
  storageBucket: "husfred-b5e27.appspot.com",
  messagingSenderId: "658274129001",
  appId: "1:658274129001:web:1946fef4903396e9f7fef8",
  measurementId: "G-GPP4MS5NDF"
};
  // Initialize Firebase
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();