import 'package:flutter/material.dart';


class AppTheme {

  static const Color _teal = Color.fromARGB(255, 80, 228, 213);
  static final Color _pink = Colors.pink.shade300;
  static final Color _darkgrey = Colors.blueGrey.shade900;
  static final Color _darkgrey1 = Colors.blueGrey.shade800;
  static final Color _lightgrey = Colors.blueGrey.shade300;
  static const Color _black = Colors.black;
  static const Color _white = Colors.white;


  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: _white,
      appBarTheme: const AppBarTheme(
          color: _teal,
          iconTheme:  IconThemeData(color: _white)),
      bottomAppBarColor: _teal,
      colorScheme:  ColorScheme.light(
          primary: _teal,
          onPrimary: _white,
          secondary: _pink,
          ),    
      textTheme: _lightTextTheme);

    static const TextTheme _lightTextTheme = TextTheme(
    headline1: TextStyle(
      color: _black,
      fontFamily: "Rubik",
      fontSize: 22,
      fontStyle: FontStyle.italic),  
    bodyText1:TextStyle(
      color: _black,
      fontFamily: "Rubik",
      fontSize: 18,
      ),
    button: TextStyle(
      color: _white,
      fontFamily: "Rubik",
      fontSize: 20,
      fontWeight: FontWeight.bold),  
  );


  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkgrey1,
      appBarTheme:  AppBarTheme(
          color: _darkgrey,
          iconTheme:  const IconThemeData(color: _white)),
      bottomAppBarColor: _darkgrey1,
      colorScheme: ColorScheme.dark(
          primary: _darkgrey,
          onPrimary: _lightgrey,
          secondary: _pink,
          tertiary: _teal,
          ),
      textTheme: _darkTextTheme,
      inputDecorationTheme: _inputDecorationTheme);


    static const TextTheme _darkTextTheme = TextTheme(
    headline1: TextStyle(
      color: _white,
      //fontFamily: "Rubik",
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic),  
    bodyText1:TextStyle(
      color: _white,
      fontFamily: "Rubik",
      fontSize: 18,
      ),
    button: TextStyle(
      color: _white,
      fontFamily: "Rubik",
      fontSize: 20,
      fontWeight: FontWeight.bold),  
  );    
  

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _white),
    ),
    floatingLabelStyle: const TextStyle(color: _white),
  );

} 