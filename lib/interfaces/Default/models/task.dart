class Task {
  final String? id;
  final String? userID; //added
  final String title;
  final String description;
  String? doc_id;
  final DateTime date_echeance;

  Task(
      {required this.id,
      this.userID="", //added
      required this.title,
      required this.description,
      required this.date_echeance,
      this.doc_id = ""});


  @override
  String toString() {
    return " title = $title description = $description date_echeance = $date_echeance id = $id doc_id = ${doc_id!}";
  }

  Map toBody() {
    return {
      "title": title,
      "description": description,
      "date_echeance": date_echeance.toString()
    };
  }

  Map toBodyUpdate() {
    return {
      "id": id.toString(),
      "title": title,
      "description": description,
      "date_echeance": date_echeance.toString(),
      "doc_id": doc_id
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'].toString(),
        doc_id: json["doc_id"],
        title: json['title'],
        description: json['description'],
        date_echeance: DateTime.parse(json['date_echeance_second']));
  }

  
}
