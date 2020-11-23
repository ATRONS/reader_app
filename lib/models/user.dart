class User {
  String key = 'abcdefghijklmnopqrstuvwxyzabcdef';
  String iv = 'abcdefghijklmnop';
  String phone = '';
  String email, firstname, lastname, token, id;

  User.fromJSON(Map<String, dynamic> json)
      : id = json['_id'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        email = json['email'],
        token = json['token'];
}
