import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:onesec/screens/home_page.dart';
import 'package:usage_stats/usage_stats.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("permission")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Permission is required for app functionality working"),
            ElevatedButton(
                onPressed: () async {
                  await UsageStats.grantUsagePermission();
                },
                child: const Text("App usage")),
            ElevatedButton(
                onPressed: () async {
                  await FlutterOverlayWindow.requestPermission();
                },
                child: const Text("Overlay")),
            ElevatedButton(
                onPressed: () async {
                  bool? usagePermission =
                      await UsageStats.checkUsagePermission();
                  if ((usagePermission != null && usagePermission) &&
                      await FlutterOverlayWindow.isPermissionGranted()) {
                    if (mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    }
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("please grand permissions")));
                    }
                  }
                },
                child: const Text("continue"))
          ],
        ),
      ),
    );
  }
}
