import 'package:flutter/material.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/search.dart';
import 'package:weather_app/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: Map<String, WidgetBuilder>.from({
        '/': (context) => Splash(),
        '/home': (context) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF7EA9E9),
                Color(0xFF131C6C),
              ],
            )
        ),
        child: const Home(),
      ),
      '/search': (context) => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7EA9E9),
                  Color(0xFF131C6C),
                ],
              )
          ),
          child: const Search(),
        ),
      }),
    );
  }
}

