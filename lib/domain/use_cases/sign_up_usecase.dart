import '../entities/user_entity.dart';
import '../repositories/firebase_repositories.dart';

///sign up use case is defined here
class SignUPUseCase {
  final FirebaseRepository repository;

  SignUPUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signUp(user);
  }
}
