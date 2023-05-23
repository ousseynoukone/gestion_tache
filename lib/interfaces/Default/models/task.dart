class Task {
  final String? id;
  final String? username;
  final int? status;
  final String? userID; //added
  final String title;
  final String description;
  String? doc_id;
  final DateTime date_echeance;
  final DateTime date_debut;
  final int state;

  Task(
      {required this.id,
      this.userID="", //added
      this.status = 0,
      required this.state,
      this.username,
      required this.title,
      required this.description,
      required this.date_echeance,
      required this.date_debut,
      this.doc_id = ""});


  @override
  String toString() {
    return " title = $title description = $description date_echeance = $date_echeance id = $id doc_id = ${doc_id!}";
  }

  Map toBody() {
    return {
      "title": title,
      "description": description,
      "date_debut": date_debut.toString(),
      "date_echeance": date_echeance.toString(),
      "state": state.toString()
    };
  }

  Map toBodyUpdate() {
    return {
      "id": id.toString(),
      "title": title,
      "description": description,
      "date_echeance": date_echeance.toString(),
      "date_debut": date_debut.toString(),
      "state": state.toString(),

      "doc_id": doc_id
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'].toString(),
        doc_id: json["doc_id"],
        title: json['title'],
        description: json['description'],
        date_echeance: DateTime.parse(json['date_echeance_second']),
        date_debut: DateTime.parse(json['date_debut_second']),
        state: json['state']
);
  }

  
}
