import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobby_tracker/models/hobby.dart';

class HobbyRepository {
  final CollectionReference _hobbiesCollection =
      FirebaseFirestore.instance.collection('hobbies');

  final CollectionReference _users_hobbiesCollection =
      FirebaseFirestore.instance.collection('users_hobbies');

  Future<List<Hobby>> getAllHobbies() async {
    QuerySnapshot snapshot = await _hobbiesCollection.get();
    List<dynamic> hobbies =
        snapshot.docs.map((doc) => doc.data()['name']).toList();

    try {
      return hobbies.cast<Hobby>();
    } catch (e) {
      return [];
    }
  }

  Future<Hobby> getHobbyById(String id) async {
    DocumentSnapshot snapshot = await _hobbiesCollection.doc(id).get();
    return Hobby.fromMap(
      snapshot.data(),
    );
  }

  Future<List<Hobby>> getAllHobbiesByUserId(String userId) async {
    // get all hobbies with paired the userId from users_hobbies collection
    QuerySnapshot snapshotOfHobbiesIds =
        await _users_hobbiesCollection.where('userId', isEqualTo: userId).get();

    QuerySnapshot snapshotOfHobbies = await _hobbiesCollection
        .where('id',
            whereIn: snapshotOfHobbiesIds.docs.map((e) => e.id).toList())
        .get();

    List<dynamic> hobbies = snapshotOfHobbies.docs.map((doc) {
      return Hobby.fromMap(doc.data());
    }).toList();

    try {
      return hobbies.cast<Hobby>();
    } catch (e) {
      return [];
    }
  }

  Future<void> addHobby(Hobby hobby) async {
    await _hobbiesCollection.add(
      hobby.toMap(hobby),
    );
  }

  Future<void> updateHobby(Hobby hobby) async {
    await _hobbiesCollection.doc(hobby.id).update(
          hobby.toMap(hobby),
        );
  }

  Future<void> deleteHobby(String id) async {
    await _hobbiesCollection.doc(id).delete();
  }
}
