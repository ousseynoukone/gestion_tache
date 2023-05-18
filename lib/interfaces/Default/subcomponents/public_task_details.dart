import 'package:flutter/material.dart';
import 'package:gestion_tache/globals/globals.dart' as globals;
import 'package:date_field/date_field.dart';
import 'package:gestion_tache/interfaces/Default/public_task.dart';

class PublicTaskDetails extends StatefulWidget {
  const PublicTaskDetails({super.key});

  @override
  State<PublicTaskDetails> createState() => _PublicTaskDetailsState();
}

class _PublicTaskDetailsState extends State<PublicTaskDetails> {
  void _goBack() async {
    //pour que le task qui est dans global soit réinitialiser si on retourne a l'acceuil , autre il risque de conserver les donnés du precendent task et dés qu'on esssaye d'ajouter un task , c'est se task la qui va se charger
    globals.task = null;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const PublicTask()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _goBack,
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        title: const Text("Details de la Tache"),
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Titre',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: globals.task?.title,
                      decoration: InputDecoration(
                        hintText: 'le titre de la tache publique',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    const Text(
                      'Description de la tache publique',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      initialValue: globals.task?.description,
                      decoration: InputDecoration(
                        hintText:
                            'Ceci est un text qui ne fut point généré mais ecrit pas moi Ousseynou hihi :)',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 35.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    const Text(
                      'Date Echeance',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DateTimeFormField(
                      enabled: false,

                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Choisir une date',
                      ),
                      initialValue: globals.task?.date_echeance,
                      firstDate: globals.task?.date_echeance != null
                          ? globals.task!.date_echeance.isAfter(DateTime.now())
                              ? DateTime.now()
                              : globals.task?.date_echeance
                          : DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 40)),
                      initialDate: DateTime.now(),
                      //autovalidateMode: AutovalidateMode.always,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
