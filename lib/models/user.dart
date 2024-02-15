class User {
  String id;
  String name;
  String surname;
  String email;
  DateTime birthdate;
  String bio;
  List<User> friends;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.birthdate,
    required this.bio,
    this.friends = const [],
  });

  Map<String, dynamic> toMap(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'surname': user.surname,
      'email': user.email,
      'birthdate': user.birthdate,
      'bio': user.bio,
      'friends': user.friends,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        surname = map['surname'],
        email = map['email'],
        birthdate = map['birthdate'],
        bio = map['bio'],
        friends = map['friends'];
}
