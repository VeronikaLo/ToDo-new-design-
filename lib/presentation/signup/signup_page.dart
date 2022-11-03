
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/auth/signupform_bloc/signupform_bloc.dart';
import 'package:todo_app/presentation/signup/widgets/signup_form.dart';

import '../../injection.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => sl<SignupformBloc>(),
        child: const SignUpForm(),),
    );
  }
}