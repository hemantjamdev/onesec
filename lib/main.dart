import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
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
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home:OverLayWindow() /*Material(
        child: Material(
            child: Container(
                height: 200,
                width: 200,
                //padding: EdgeInsets.all(50),
                // margin: EdgeInsets.all(50),
                color: Colors.red,
                child: const Center(child: Text("My overlay body")))),
      )*/));
}
/*

class OverLayWindow extends StatelessWidget {
  const OverLayWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text("over lay screen title")),
        body: Material(
            child: Container(
                height: 200,
                width: 200,
                //padding: EdgeInsets.all(50),
                // margin: EdgeInsets.all(50),
                color: Colors.red,
                child: const Center(child: Text("My overlay body")))),
      ),
    );
  }
}*/
/*
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();

  runApp(const MyApp());
}

Future initializeService() async {
  final service = FlutterBackgroundService();
  service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStartOnBoot: true,
    ),
  );
  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  if (service is AndroidServiceInstance) {
    service.on("setAsForegroundService").listen((event) {
      service.setAsForegroundService();
    });
    service.on("setAsBackgroundService").listen((event) {
      service.setAsBackgroundService();
    });
    service.on("stopSelf").listen((event) {
      service.stopSelf();
    });
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      // if () {
      service.setForegroundNotificationInfo(
        title: "hemant service",
        content: "updating at every 2 second ${DateTime.now()}",
      );
      log("-----> running <------");
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//final permissio=Permission.notification.request();
    Permission.notification.request();

    String text = "stop service";
    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  FlutterBackgroundService().invoke("setAsForegroundService");
                },
                child: const Text("forground")),
            ElevatedButton(
                onPressed: () {
                  FlutterBackgroundService().invoke("setAsBackgroundService");
                },
                child: const Text("background")),
            ElevatedButton(
                onPressed: () async {
                  final service = FlutterBackgroundService();
                  if (await service.isRunning()) {
                    FlutterBackgroundService().invoke("stopSelf");
                    text = "start service";
                  } else {
                    service.startService();
                  }
                },
                child: Text(text)),
          ],
        ),
      ),
    );
  }
}
*/
