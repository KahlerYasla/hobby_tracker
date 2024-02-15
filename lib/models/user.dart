class User {
  String id;
  String name;
  String surname;
  String email;
  DateTime birthdate;
  String bio;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.birthdate,
    required this.bio,
  });

  Map<String, dynamic> toMap(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'surname': user.surname,
      'email': user.email,
      'birthdate': user.birthdate,
      'bio': user.bio,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        surname = map['surname'],
        email = map['email'],
        birthdate = map['birthdate'],
        bio = map['bio'];
}
