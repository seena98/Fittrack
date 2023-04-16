import '../entities/user_entity.dart';
import '../repositories/firebase_repositories.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signIn(user);
  }
}
