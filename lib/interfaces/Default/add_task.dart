import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/Default/accueil.dart';
import 'package:date_field/date_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTask();
}

class _AddTask extends State<AddTask> {
  final _formGlobalKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  DateTime date_echeance = DateTime.now();

  void _goBack() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Accueil()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Creer une Nouvelle Tache'),
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: _goBack,
          icon: Icon(
            Icons.arrow_back,
          ),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                key: _formGlobalKey,
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
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Saisir un titre valide';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'le titre de votre tache',
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
                      'Description',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Saisir une description valide';
                        }
                        return null;
                      },
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
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Choisir une date',
                      ),
                      firstDate: DateTime.now().add(const Duration(days: 10)),
                      lastDate: DateTime.now().add(const Duration(days: 40)),
                      initialDate: DateTime.now().add(const Duration(days: 20)),
                      //autovalidateMode: AutovalidateMode.always,
                      onDateSelected: (DateTime value) {
                        setState(() {
                          date_echeance = value;
                        });
                      },
                      validator: (DateTime? e) {
                        return (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null;
                        //return null;
                      },
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formGlobalKey.currentState!.validate()) {
                          print("formulaire validé");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'Ajouter'.toUpperCase(),
                      ),
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
