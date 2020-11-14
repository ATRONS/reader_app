class Genere {
  String id, name;
  List<dynamic> options;

  Genere.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        options = json['options'];
}
