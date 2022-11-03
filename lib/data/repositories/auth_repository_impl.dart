import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/failures/auth_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entities/user.dart';
import 'package:todo_app/domain/repositories/auth_repository.dart';
import 'package:todo_app/data/extensions/firebase_user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository{

  final FirebaseAuth firebaseAuth;
  AuthRepositoryImpl({required this.firebaseAuth});



  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({required String email, required String password}) async{
    
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch(e){
        if(e.code == 'email-already-in-use'){
          return left(EmailAlreadyInUseFailure());
        }else{
          return left(ServerFailure());
        }
    }

  }



  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({required String email, required String password}) async{
    
    try{
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch(e){
        if(e.code == 'wrong-password' || e.code == 'user-not-found'){
          return left(InvalidEmailAndPasswordCombination());
        }else{
          return left(ServerFailure());
        }
    }

  }
  

  @override
  /*
  Future<void> signOut() async{
    await firebaseAuth.signOut();
  }
  */

  Future<void> signOut() => Future.wait(
    [
      firebaseAuth.signOut(),
    ]
  );

  @override
  Option<CustomUser> getSignedInUser() => optionOf(firebaseAuth.currentUser?.toDomain());

}