
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/errors/errors.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../injection.dart';

extension FirestorExt on FirebaseFirestore {  // extension, to navigate to a user with ID (pfad in FB collection)

  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }
}

extension DocumentReferenceExt on DocumentReference { // extension, to navigate to todo-collection
  CollectionReference<Map<String, dynamic>> get todoCollection =>
      collection("todo");
}