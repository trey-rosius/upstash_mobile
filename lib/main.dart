import 'package:flutter/material.dart';

import 'account/create_profile_screen.dart';
import 'home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(primaryColor: Color(0xFF161616),fontFamily: 'Montserrat');
    return MaterialApp(
      title: 'upstash mobile app',

      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary:Color(0xFFf94c84) )
      ),
      home: CreateProfileScreen(),
    );
  }
}

