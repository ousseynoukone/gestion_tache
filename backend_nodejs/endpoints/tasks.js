const { db } = require("../util/firebase");
const { collection, getDocs, addDoc, updateDoc, doc , deleteDoc } = require("firebase/firestore"); 


exports.getTasks = async (req, response) => {
    const querySnapshot = await getDocs(collection(db, "tasks"));
    try{
        let data = [];

        querySnapshot.forEach((doc) => {
            if(doc.data()['userID']=="0")
            {
            let doc_id = doc.ref.id ;
            let t = doc.data()["date_echeance"] ;
            let date = new Date(t.seconds * 1000 + t.nanoseconds / 1000000);
            let obj = { id: doc.id, date_echeance_second: date, doc_id: doc_id, ...doc.data()}
            data.push(obj);
            }

          });
            
          if (response) {
            response.status(201).json(data);
          } else {
            console.log("Response is undefined");
          }
                            
    } catch (error) {
        console.log(error);
     //   return res
      //  .status(500)
        //.json({ general: "Something went wrong, please try again"});          
    }
};





exports.deleteTask = async (request, response) => {
    try{
   await deleteDoc(doc(db, "tasks",request.params.id ));
   return response.status(200).json({ message: "La tâche a été supprimée avec succès." });

}catch(error){
    return response.status(500).json({ message: "Erreur lors de la suppresion !  " });
}
}
  
exports.numberItem = async (req, res) => {
    const querySnapshot = await getDocs(collection(db, "tasks"));
    //const booksRef = db.collection('tasks');
   
        try{
            let number = 0;
    
            querySnapshot.forEach((doc) => {
                if(doc.data()['userID']=="0")
                {
                    number += 1;

                }
               

              });
         res.status(201).json({ number : number });
        
        } catch (error) {
        console.log(error); 
          //  return res
          //  .status(500)
          //  .json({ general: "Something went wrong, please try again"});          
        }

    

};


exports.addTask = async (request, response) => {
    //console.log(request.body);
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

        return response.status(201).json({ message: "La tâche a été ajoutée avec succès." });




        // let data = await this.getTasks(req,response)
        // response.status(200).json(data);
        // console.log(data);
        
    } catch (error) {
        return response
        .status(500)
        .json({ general: "Echec de j'aout de tache ! "});          
    }
};


exports.updateTask = async (request, response) => {
    //console.log(request.body);
    try{

        const date = new Date(request.body.date_echeance);

        const docRef = doc(db, "tasks", request.body.doc_id);

        const data = {
            //id: parseInt(request.body.id),
            title: request.body.title,
            description: request.body.description,
            date_echeance: date
        };

          updateDoc(docRef, data)
                .then(docRef => {
                    //console.log("An Update Has Been Done");
                })


        return response.status(201).json({ success: true , statusCode: 201 });
        
    } catch (error) {
        return response
        .status(500)
        .json({ general: "Something went wrong, please try again"});          
    }
};
