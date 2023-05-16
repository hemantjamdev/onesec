import 'package:flutter/material.dart';

import 'screens/home_page.dart';

class OneSec extends StatelessWidget {
  const OneSec({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
