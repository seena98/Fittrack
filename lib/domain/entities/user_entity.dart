import 'package:equatable/equatable.dart';

///this is a user model
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

  ///props are used for Equatable functions
  @override
  List<Object?> get props => [
        name,
        email,
        uid,
        password,
      ];
}
