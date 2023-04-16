import '../repositories/firebase_repositories.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUId();
  }
}
