import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/auth/auth_bloc/auth_bloc.dart';

import '../routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state){
        if(state is AuthStateAuthenticated){
          //navigate to home
          AutoRouter.of(context).replace(const HomePageRoute());
        } else if(state is AuthStateUnauthenticated){
          //navigate to SignUpPage
          AutoRouter.of(context).replace(const SignUpPageRoute());
        }
      },
      child: Scaffold(
      body: Center(
        child:CircularProgressIndicator(color: Theme.of(context).colorScheme.tertiary,) ),
    ),);
  }
}