const express = require('express');
const firebase = require('firebase');

const app = express();

const firebaseConfig = {
    apiKey: "AIzaSyC0A38OSiEGk9vKLLF02TCLfLgJkYoKhVE",
    authDomain: "yowl-8ba22.firebaseapp.com",
    projectId: "yowl-8ba22",
    storageBucket: "yowl-8ba22.appspot.com",
    messagingSenderId: "563570543946",
    appId: "1:563570543946:web:2785e47df1cdfd7a4c05b3"
  };

  firebase.initializeApp(firebaseConfig);

  const db = firebase.firestore();

  app.get('/api', async (req, res) => {
    try {
        let response = [];

        await db.collection('users').get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                response.push(doc.data());
            }

            return res.status(200).send(response);
        });
    } catch (error) {
        return res.status(500).send(error);
    }
});


const port = process.env.PORT || 1000;

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});