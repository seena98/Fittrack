import '../repositories/firebase_repositories.dart';

///is user signed in or not use case is defined here
class IsSignedInUseCase {
  final FirebaseRepository repository;

  IsSignedInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignedIn();
  }
}
