enum GenereLang { english, amharic }

class Genere {
  String id, name;
  List<dynamic> options;

  Genere.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        options = json['options'];

  String getGenereName(GenereLang lang) {
    final langStr = lang == GenereLang.english ? "english" : "amharic";
    final chosen =
        this.options.where((option) => option['lang'] == langStr).toList();
    return chosen.length > 0 ? chosen[0]['value'] : "default";
  }
}
