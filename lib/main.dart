import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/injection.dart' as di;
import 'package:todo_app/presentation/routes/router.gr.dart' as r;
import 'package:todo_app/presentation/signup/signup_page.dart';

import 'app_theme.dart';
import 'application/auth/auth_bloc/auth_bloc.dart';
import 'injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _approuter = r.AppRouter();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => sl<AuthBloc>()..add(AuthCheckRequestEvent())),
      ], 
      child: MaterialApp.router(
      routeInformationParser: _approuter.defaultRouteParser(),
      routerDelegate: _approuter.delegate(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
    ) );
  }
}
