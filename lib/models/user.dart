class User {
  String key;
  String iv;
  String phone = '';
  String email, firstname, lastname, token, id;

  User.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        email = json['email'],
        key = json['key'],
        iv = json['iv'],
        token = json['token'];

  Map<String, dynamic> toUserJSON() {
    return {
      '_id': this.id,
      'iD': this.id,
      'firstname': this.firstname,
      'lastname': this.lastname,
      'email': this.email,
      'key': this.key,
      'iv': this.iv,
      'token': this.token,
    };
  }
}
