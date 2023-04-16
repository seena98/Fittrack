import '../repositories/firebase_repositories.dart';

///GetCurrentUid use case is defined here
class GetCurrentUidUseCase {
  final FirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUId();
  }
}
