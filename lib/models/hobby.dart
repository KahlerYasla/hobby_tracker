class Hobby {
  final String id;
  final String name;

  Hobby({
    required this.id,
    required this.name,
  });

  static Hobby fromMap(Map<String, dynamic> map) {
    return Hobby(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap(Hobby hobby) {
    return {
      'id': hobby.id,
      'name': hobby.name,
    };
  }
}
