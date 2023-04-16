import '../entities/user_entity.dart';
import '../repositories/firebase_repositories.dart';

///GetCreateCurrentUser use case is defined here
class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}
