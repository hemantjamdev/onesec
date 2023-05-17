import 'package:flutter/material.dart';
import 'package:onesec/screens/splash.dart';


class OneSec extends StatelessWidget {
  const OneSec({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
