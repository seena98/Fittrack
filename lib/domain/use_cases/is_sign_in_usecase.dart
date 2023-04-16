import '../repositories/firebase_repositories.dart';

class IsSignedInUseCase {
  final FirebaseRepository repository;

  IsSignedInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignedIn();
  }
}
