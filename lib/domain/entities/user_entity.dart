import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? uid;
  final String? password;

  const UserEntity({
    this.name,
    this.email,
    this.uid,
    this.password,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        uid,
        password,
      ];
}