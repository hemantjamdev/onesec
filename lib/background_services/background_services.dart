import 'dart:async';
import 'dart:developer';

import 'package:flutter_background_service/flutter_background_service.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class BackgroundServices {
  static Future initializeService() async {
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
  static void onStart(ServiceInstance service) {
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
}
