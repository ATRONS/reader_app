class Review {
  String comment;
  int starvalue;
  Map<String, dynamic> username;

  Review.fromJSON(Map<String, dynamic> json)
      : username = json['reader'],
        comment = json['description'],
        starvalue = json['value'];
}
