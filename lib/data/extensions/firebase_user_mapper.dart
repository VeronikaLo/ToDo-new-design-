
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/id.dart';
import '../../domain/entities/user.dart';

extension FirebaseUserMapper on User {
  CustomUser toDomain() {
    return CustomUser(id: UniqueID.fromUniqueString(uid));
  }
}