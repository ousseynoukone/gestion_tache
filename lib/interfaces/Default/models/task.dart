class Task {
  final int? id;
  final String title;
  final String description;
  String? doc_id;
  final DateTime date_echeance;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.date_echeance,
      this.doc_id = ""});

  @override
  String toString() {
    return " title = " +
        this.title +
        " description = " +
        this.description +
        " date_echeance = " +
        this.date_echeance.toString() +
        " id = " +
        id.toString() +
        " doc_id = " +
        doc_id!;
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
        id: json['id'],
        doc_id: json["doc_id"],
        title: json['title'],
        description: json['description'],
        date_echeance: DateTime.parse(json['date_echeance_second']));
  }
}
