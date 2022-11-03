import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/failures/auth_failures.dart';
import 'package:todo_app/presentation/pres_core/custom_button.dart';

import '../../../application/auth/signupform_bloc/signupform_bloc.dart';
import '../../routes/router.gr.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    late String _email;
    late String _password;

    // validation function (email)
    String? validateEmail(String? input) {
      const emailRegEx =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

      if (input == null || input.isEmpty) {
        return "Please enter email";
      } else if (RegExp(emailRegEx).hasMatch(input)) {
        _email = input;
        return null;
      } else {
        return "Invalid email format";
      }
    }

    // validation function (password)
    String? validatePassword(String? input) {
      if (input == null || input.isEmpty) {
        return "Please enter password";
      } else if (input.length >= 6) {
        _password = input;
        return null;
      } else {
        return "Short password";
      }
    }

    // function to differantiate the failer messages
    String mapFailureMessage(AuthFailure failure){
      
      switch(failure.runtimeType){
        case ServerFailure:
          return 'Something went wrong';
        case EmailAlreadyInUseFailure: 
          return 'Email is already in use';
        case InvalidEmailAndPasswordCombination:
          return 'Invalid email and password combination'; 
        default:
          return 'Something went wrong'; 
      }
    }

    return BlocConsumer<SignupformBloc, SignupformState>(
      listenWhen: (p,c) => p.authFailureOrSuccessOption != c.authFailureOrSuccessOption,
      listener: (context, state) {

        state.authFailureOrSuccessOption.fold(
          () => {}, 
          (eitherFailOrSuccess) => eitherFailOrSuccess.fold(
            (failure) { // show error message if auth is not successful

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        mapFailureMessage(failure),
                        style: themeData.textTheme.bodyText1,
                      ),
                      backgroundColor: Colors.redAccent,
                    ));

            }, 
            (_) => { // navigate to homapage if auth is successful,
              AutoRouter.of(context).replace(const HomePageRoute())
            }));
      },
      builder: (context, state) {
        return Form(
          key: formkey,
          autovalidateMode: state.showValidationMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 80,
              ),
              Text('Welcome',
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.headline1!.copyWith(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 4,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text('Please register or sign in',
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.headline1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 4,
                  )),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                validator: validateEmail, 
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: validatePassword,
                cursorColor: Colors.white,
                obscureText: true, // hides input
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                buttonText: 'Sign In',
                callback: () {

                  if (formkey.currentState!.validate()) {  // if validation ok --> BlocEvent is added
                    BlocProvider.of<SignupformBloc>(context).add(SignUpWithEmailAndPasswordPressed(email: _email , password: _password ));
                    print('validated email');

                  } else {  // if validation is not ok --> BlocEvent with null values (in BlocEvent - strings as nullable type)

                  BlocProvider.of<SignupformBloc>(context).add(SignUpWithEmailAndPasswordPressed(email: null , password: null ));

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Invalid data',
                        style: themeData.textTheme.bodyText1,
                      ),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  buttonText: 'Register',
                  callback: () {
                    
                    if (formkey.currentState!.validate()) {  // if validation ok --> BlocEvent is added
                    BlocProvider.of<SignupformBloc>(context).add(RegisterWithEmailAndPasswordPressed(email: _email , password: _password ));
                    print('validated password');

                  } else {  // if validation is not ok --> BlocEvent with null values (in BlocEvent - strings as nullable type)

                  BlocProvider.of<SignupformBloc>(context).add(RegisterWithEmailAndPasswordPressed(email: null , password: null ));

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Invalid data',
                        style: themeData.textTheme.bodyText1,
                      ),
                      backgroundColor: Colors.redAccent,
                    ));
                  }  


                  }),
              const SizedBox(
                height: 30,
              ),
              // this appears only if state is isSubmitting
              if(state.isSubmitting)...[
              LinearProgressIndicator( color: themeData.colorScheme.tertiary,),
              const SizedBox(height: 10,),]
            ],
          ),
        );
      },
    );
  }
}
