import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamkiss/constants/theme.dart';
import 'package:jamkiss/screens/home.dart';
import 'package:jamkiss/screens/single.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
              primary: primaryColor,
              tertiary: tertiaryColor,
              secondary: secondaryColor,
              background: bgColor),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontFamily: 'Chillax',
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                height: 1,
                color: textColor),
            headline2: TextStyle(
                fontFamily: 'Chillax',
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                height: 1,
                color: textColor),
            headline3: TextStyle(
                fontFamily: 'Chillax',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                height: 1,
                color: textColor),
            headline6: TextStyle(
                fontFamily: 'Chillax',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                height: 1,
                color: textColor),
            bodyText1: TextStyle(
                fontFamily: 'Chillax',
                fontSize: 18.0,
                height: 1,
                fontWeight: FontWeight.w500,
                color: textColor),
            button: TextStyle(
                fontFamily: 'Chillax',
                fontSize: 14.0,
                height: 1,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return CupertinoPageRoute(
                  builder: (_) => const HomeScreen(), settings: settings);
            case '/single':
              return CupertinoPageRoute(
                  builder: (_) => const SingleTrackScreen(),
                  settings: settings);
          }
        });
  }
}
