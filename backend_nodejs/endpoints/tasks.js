const { db } = require("../util/firebase");
const { collection, getDocs, addDoc, updateDoc } = require("firebase/firestore"); 

exports.getTasks = async (req, res) => {
    const querySnapshot = await getDocs(collection(db, "tasks"));
    //const booksRef = db.collection('tasks');
    try{
        let data = [];

        querySnapshot.forEach((doc) => {
            let doc_id = doc.ref.id ;
            let t = doc.data()["date_echeance"] ;
            let date = new Date(t.seconds * 1000 + t.nanoseconds / 1000000);
            //.toLocaleTimeString('en-us', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
            
            //console.log(date);
            let obj = { id: doc.id, date_echeance_second: date, doc_id: doc_id, ...doc.data()}
            data.push(obj);
          });
     res.status(201).json(data);
        
    } catch (error) {
        console.log(error);
        return res
        .status(500)
        .json({ general: "Something went wrong, please try again"});          
    }
};


exports.addTask = async (request, response) => {
    console.log(request.body);
    const querySnapshot = await getDocs(collection(db, "tasks"));
    try{
        let number = 0;

        querySnapshot.forEach((doc) => {
           number += 1;
          });


        const date = new Date(request.body.date_echeance);

        const docRef = await addDoc(collection(db, "tasks"), {
            id: number + 1,
            title: request.body.title,
            description: request.body.description,
            date_echeance: date
          });

          let data = this.getTasks()

        response.status(200).json(data);
        
    } catch (error) {
        return res
        .status(500)
        .json({ general: "Something went wrong, please try again"});          
    }
};


exports.updateTask = async (request, response) => {
    //console.log(request.body);
    try{


        const date = new Date(request.body.date_echeance);

        const docRef = doc(db, "tasks", request.body.doc_id);

        const data = {
            id: request.body.id,
            title: request.body.title,
            description: request.body.description,
            date_echeance: date
        };

          updateDoc(docRef, data)
                .then(docRef => {
                    console.log("A New Document Field has been added to an existing document");
                })


        response.status(200).json({ success: true , statusCode: 201 });
        
    } catch (error) {
        return response
        .status(500)
        .json({ general: "Something went wrong, please try again"});          
    }
};