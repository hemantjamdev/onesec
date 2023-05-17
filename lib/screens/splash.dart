import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:onesec/screens/home_page.dart';
import 'package:onesec/screens/permission_screen.dart';
import 'package:usage_stats/usage_stats.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  checkPermission() async {
    bool? usagePermission = await UsageStats.checkUsagePermission();
    bool overLayPermission = await FlutterOverlayWindow.isPermissionGranted();
    if ((usagePermission != null && usagePermission) && overLayPermission) {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } else {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PermissionScreen()));
      }
    }
  }

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
