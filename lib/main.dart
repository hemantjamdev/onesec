import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onesec/background_services/background_services.dart';
import 'package:onesec/screens/over_lay.dart';

import 'onesec_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundServices.initializeService();
  runApp(const OneSec());
}

@pragma("vm:entry-point")
void overlayMain() {
  log("over lay is running");
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverLayWindow(),
    ),
  );
}
