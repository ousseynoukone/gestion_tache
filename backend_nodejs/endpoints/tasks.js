const { db } = require("../util/firebase");
const { collection, getDocs, addDoc, updateDoc, doc , deleteDoc } = require("firebase/firestore"); 








exports.getTasksByUser = async (request, response) => {
    console.log("get tasks  by user ran ! ")

    const querySnapshot = await getDocs(collection(db, "tasks"));
    try{
        let data = [];

        querySnapshot.forEach((doc) => {
            if(doc.data()['userID']==request.params.id)
            {
            let doc_id = doc.ref.id ;
            let t = doc.data()["date_echeance"] ;
            let t1 = doc.data()["date_debut"] ;
            let date = new Date(t.seconds * 1000 + t.nanoseconds / 1000000);
            let date1 = new Date(t1.seconds * 1000 + t1.nanoseconds / 1000000);

            let obj = { id: doc.id, date_echeance_second: date,date_debut_second: date1, doc_id: doc_id, ...doc.data()}
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





exports.getTasks = async (request, response) => {
    console.log("get tasks ran ! ")

    const querySnapshot = await getDocs(collection(db, "tasks"));
    try{
        let data = [];

        querySnapshot.forEach((doc) => {
            if(doc.data()['userID']=="0")
            {
            let doc_id = doc.ref.id ;
            let t = doc.data()["date_echeance"] ;
            let t1 = doc.data()["date_debut"] ;
            let date = new Date(t.seconds * 1000 + t.nanoseconds / 1000000);
            let date1 = new Date(t1.seconds * 1000 + t1.nanoseconds / 1000000);
            let obj = { id: doc.id, date_echeance_second: date,date_debut_second: date1, doc_id: doc_id, ...doc.data()}
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
    console.log("delete task ran ! ")

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
     console.log("numberItem ran ! ")
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





exports.numberItemByUser = async (request, res) => {
  console.log("get number of tasks by user ran ! ")

  const querySnapshot = await getDocs(collection(db, "tasks"));
  //const booksRef = db.collection('tasks');
   console.log("numberItem ran ! ")
      try{
        let number = 0;
        let number1 = 0;
        let number2 = 0;
        let number3 = 0;
        var allNumber = []
  
          querySnapshot.forEach((doc) => {
           
              if(doc.data()['userID']==request.params.id &&  (doc.data()['status']==0 || doc.data()['status']==2 ))
              {
                  number += 1;

              }
              if(doc.data()['userID']==request.params.id && (doc.data()['status']==0 || doc.data()['status']==2 ) && doc.data()['state']==0 )
              {
                  number1 += 1;

              }

              if(doc.data()['userID']==request.params.id &&  (doc.data()['status']==0 || doc.data()['status']==2 ) && doc.data()['state']==1 )
              {
                  number2 += 1;

              }

              if(doc.data()['userID']==request.params.id &&  (doc.data()['status']==0 || doc.data()['status']==2 ) && doc.data()['state']==2)
              {
                  number3 += 1;

              }
             

            });

            allNumber.push(number)
            allNumber.push(number1)
            allNumber.push(number2)
            allNumber.push(number3)
       res.status(201).json({ allNumber : allNumber });
      
      } catch (error) {
      console.log(error); 
        //  return res
        //  .status(500)
        //  .json({ general: "Something went wrong, please try again"});          
      }

  

};




exports.addTask = async (request, response) => {
    //console.log(request.body);
    console.log("add task ran ! ")

    const querySnapshot = await getDocs(collection(db, "tasks"));
    try{
        let number = 0;

        querySnapshot.forEach((doc) => {
           number += 1;
          });


          const date = new Date(request.body.date_echeance);
          const date_debut = new Date(request.body.date_debut);

        const docRef = await addDoc(collection(db, "tasks"), {
            id: number + 1,
            title: request.body.title,
            state: request.body.state,
            description: request.body.description,
            date_echeance: date,
            date_debut: date_debut
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
    console.log("update task ran ! ")

    try{

      const date = new Date(request.body.date_echeance);
      const date_debut = new Date(request.body.date_debut);

        const docRef = doc(db, "tasks", request.body.doc_id);

        const data = {
            //id: parseInt(request.body.id),
            title: request.body.title,
            state: request.body.state,
            description: request.body.description,
            date_echeance: date,
            date_debut: date_debut
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
