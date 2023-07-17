class AppUser {
  var _name, _surname, _id;

  AppUser(
      {required String name, required String surname, required String id}) {
    _name = name;
    _surname = surname;
    _id = id;
  }


  String getName() {
    return _name;
  }

  String getSurname() {
    return _surname;
  }

  String getId() {
    return _id;
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'surname': _surname,
      };

  static fromJson(Map<String, dynamic> json) => AppUser(
      name: json['name'],
      surname: json['surname'],
      id: json['id']);
}
