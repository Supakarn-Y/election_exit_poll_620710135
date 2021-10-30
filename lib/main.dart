import 'package:election_exit_poll_620710135/pages/homepage.dart';
import 'package:election_exit_poll_620710135/pages/scorepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),
      routes: {
        homePage.routeName: (context) => const homePage(),
        scorePage.routeName: (context) => const scorePage(),

      },
      home: homePage(),
    );
  }
}

