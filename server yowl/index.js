<<<<<<< Updated upstream
import express from 'express';
import firebase from 'firebase/compat/app';
import 'firebase/compat/auth';
import 'firebase/compat/firestore';
=======
const express = require('express');
const firebase = require('firebase/compat/app');
require('firebase/compat/auth');
require('firebase/compat/firestore');
>>>>>>> Stashed changes

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


app.get('/api/users', async (req, res) => {
    try {
        let response = [];

        await db.collection('users').get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                response.push(doc.data());
            }

<<<<<<< Updated upstream
            

=======
>>>>>>> Stashed changes
            console.log('Data from Firestore:', response); 

            return res.status(200).send(response);
        });
    } catch (error) {
        console.error('Error fetching data from Firestore:', error.stack);
<<<<<<< Updated upstream
=======
        return res.status(500).send(error);
    }
});
app.get('/api/users/:id', async (req, res) => {
    try {
        const userId = req.params.id;

        const doc = await db.collection('users').doc(userId).get(); 

        if (doc.exists) {
            console.log('Data from Firestore:', doc.data());
            return res.status(200).send(doc.data()); 
        } else {
            return res.status(404).send({ message: 'User not found' }); 
        }
    } catch (error) {
        console.error('Error fetching user from Firestore:', error.stack);
        return res.status(500).send(error);
    }
});
app.get('/api/posts', async (req, res) => {
    try {
        let response = [];

        await db.collection('posts').get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                response.push(doc.data());
            }

            console.log('Data from Firestore:', response); 

            return res.status(200).send(response);
        });
    } catch (error) {
        console.error('Error fetching data from Firestore:', error.stack);
        return res.status(500).send(error);
    }
});
app.get('/api/posts/:id', async (req, res) => {
    try {
        const userId = req.params.id;

        const doc = await db.collection('posts').doc(userId).get(); 

        if (doc.exists) {
            console.log('Data from Firestore:', doc.data());
            return res.status(200).send(doc.data()); 
        } else {
            return res.status(404).send({ message: 'User not found' }); 
        }
    } catch (error) {
        console.error('Error fetching user from Firestore:', error.stack);
        return res.status(500).send(error);
    }
});
app.get('/api/animals', async (req, res) => {
    try {
        let response = [];

        await db.collection('animals').get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                response.push(doc.data());
            }

            console.log('Data from Firestore:', response); 

            return res.status(200).send(response);
        });
    } catch (error) {
        console.error('Error fetching data from Firestore:', error.stack);
>>>>>>> Stashed changes
        return res.status(500).send(error);
    }
});

app.get('/', (req, res) => {
    res.send('Hello, world!');
});


app.get('/users', (req, res) => {
    res.send('This is the /users route');
});



app.get('/api/posts', async (req, res) => {
    try {
        let response = [];

        await db.collection('posts').get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                response.push(doc.data());
            }

            

            console.log('Data from Firestore:', response); 

            return res.status(200).send(response);
        });
    } catch (error) {
        console.error('Error fetching data from Firestore:', error.stack);
        return res.status(500).send(error);
    }
});


app.get('/api/users', async (req, res) => {
    try {
        let response = [];

        await db.collection('users').get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                response.push(doc.data());
            }

            

            console.log('Data from Firestore:', response); 

            return res.status(200).send(response);
        });
    } catch (error) {
        console.error('Error fetching data from Firestore:', error.stack);
        return res.status(500).send(error);
    }
});




app.get('/api/animals', async (req, res) => {
    try {
        let response = [];

        await db.collection('animals').get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                response.push(doc.data());
            }

            

            console.log('Data from Firestore:', response); 

            return res.status(200).send(response);
        });
    } catch (error) {
        console.error('Error fetching data from Firestore:', error.stack);
        return res.status(500).send(error);
    }
});


app.get('/api/comments', async (req, res) => {
    try {
        let response = [];

        await db.collection('comments').get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                response.push(doc.data());
            }

            

            console.log('Data from Firestore:', response); 

            return res.status(200).send(response);
        });
    } catch (error) {
        console.error('Error fetching data from Firestore:', error.stack);
        return res.status(500).send(error);
    }
});


app.get('/', (req, res) => {
    res.send('Hello, world!');
});


app.get('/users', (req, res) => {
    res.send('This is the /users route');
});

app.get('/posts', (req, res) => {
    res.send('This is the /users route');
});

app.get('/animals', (req, res) => {
    res.send('This is the /users route');
});

app.get('/comments', (req, res) => {
    res.send('This is the /users route');
});

const port = process.env.PORT || 1000;

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
<<<<<<< Updated upstream
=======

  db.collection('posts').doc('1').get().then(postDoc => {
    if (postDoc.exists) {
      const post = postDoc.data();
      const userRef = post.author;
      userRef.get().then(userDoc => {
        if (userDoc.exists) {
          const user = userDoc.data();
          // Maintenant, vous avez accès aux données de l'utilisateur
        }
      });
    }
  });
  
  db.collection('posts').get().then(querySnapshot => {
    let response = [];

    querySnapshot.forEach(doc => {
        let postData = doc.data();
        
        // Transformer la référence de document en un format simple, par exemple, l'ID du document
        if (postData.author && postData.author.id) {
            postData.author = postData.author.id;
        } else {
            // Si la référence de document n'a pas d'ID, vous pouvez extraire son chemin
            postData.author = postData.author.path;
        }

        response.push(postData);
    });

    console.log('Data from Firestore:', response);
    return res.status(200).send(response);
}).catch(error => {
    console.error('Error fetching data from Firestore:', error.stack);
    return res.status(500).send(error);
});
>>>>>>> Stashed changes
