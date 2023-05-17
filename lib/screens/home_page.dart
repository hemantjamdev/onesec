import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:usage_stats/usage_stats.dart';

import 'app_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<EventUsageInfo> events = [];
  List<UsageInfo> usageStats = [];

  getUsage() async {
    DateTime endDate = DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    UsageStats.grantUsagePermission();

    bool? isPermission = await UsageStats.checkUsagePermission();
    isPermission != null && isPermission
        ? null
        : UsageStats.grantUsagePermission();
    events = await UsageStats.queryEvents(startDate, endDate);
    usageStats = await UsageStats.queryUsageStats(startDate, endDate);
  }

  getUsageForApp() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(minutes: 2));

    Map<String, UsageInfo> app =
        await UsageStats.queryAndAggregateUsageStats(startDate, endDate);
    app.keys.toList().contains("com.android.chrome")
        ? log("yyyyaayyyy")
        : log("nopeeeeeee");

  }

  checkPermission() async {
    await FlutterOverlayWindow.isPermissionGranted()
        ? null
        : FlutterOverlayWindow.requestPermission();
  }

  @override
  void initState() {
    checkPermission();
    super.initState();
    getUsage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUsageForApp();
        },
      ),*/
      appBar: AppBar(title: const Text("Home page")),
      body: const InstallAppsList(),
    );
  }
}
