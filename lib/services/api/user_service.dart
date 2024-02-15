import 'package:hobby_tracker/repositories/user_repository.dart';
import 'package:hobby_tracker/models/user.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();

  Future<User> getCurrentUser(String email) async {
    return _userRepository.getCurrentUser(email);
  }

  Future<void> signOut() async {
    return _userRepository.signOut();
  }
}
