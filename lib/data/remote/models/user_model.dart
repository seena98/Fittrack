import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_entity.dart';

///user model extending user entity to handle json serialization
class UserModel extends UserEntity {
  const UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? password,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          password: password,
        );

  ///translated data from db into objects
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      name: documentSnapshot.get('name'),
      uid: documentSnapshot.get('uid'),
      email: documentSnapshot.get('email'),
    );
  }

  ///translates object into data ready to send to db
  Map<String, dynamic> toDocument() {
    return {"uid": uid, "email": email, "name": name};
  }
}
