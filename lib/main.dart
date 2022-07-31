import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamkiss/components/mini_player.dart';
import 'package:jamkiss/constants/theme.dart';
import 'package:jamkiss/model/current_playing.dart';
import 'package:jamkiss/screens/home.dart';
import 'package:jamkiss/screens/single.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CurrentPlayingModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JAMKISS - Musics for jamming 🎶',
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
                fontSize: 20.0,
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
        builder: ((context, child) {
          return Stack(
            children: [
              child!,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [MiniPlayer()],
              )
            ],
          );
        }),
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
          return null;
        });
  }
}
