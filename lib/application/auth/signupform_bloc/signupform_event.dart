part of 'signupform_bloc.dart';

@immutable
abstract class SignupformEvent {}

// we have 2 events: sign in and registration

class SignUpWithEmailAndPasswordPressed extends SignupformEvent{
  final String? email;
  final String? password;

  SignUpWithEmailAndPasswordPressed({required this.email, required this.password});
}


class RegisterWithEmailAndPasswordPressed extends SignupformEvent{
  final String? email;
  final String? password;

  RegisterWithEmailAndPasswordPressed({required this.email, required this.password});
}
