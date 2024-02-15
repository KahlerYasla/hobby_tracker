import 'package:hobby_tracker/models/hobby.dart';
import 'package:hobby_tracker/repositories/hobby_repository.dart';

class HobbyService {
  final HobbyRepository _repository = HobbyRepository();

  Future<List<Hobby>> getAllHobbies() async {
    return await _repository.getAllHobbies();
  }

  Future<List<Hobby>> getAllHobbiesByUserId(String userId) async {
    return await _repository.getAllHobbiesByUserId(userId);
  }

  Future<Hobby> getHobbyById(String id) async {
    return await _repository.getHobbyById(id);
  }

  Future<void> addHobby(Hobby hobby) async {
    await _repository.addHobby(hobby);
  }

  Future<void> updateHobby(Hobby hobby) async {
    await _repository.updateHobby(hobby);
  }

  Future<void> deleteHobby(String id) async {
    await _repository.deleteHobby(id);
  }
}
