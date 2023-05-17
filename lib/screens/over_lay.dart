// overlay entry point
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class OverLayWindow extends StatelessWidget {
  const OverLayWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        floatingActionButton: FloatingActionButton.extended(
            label: const Text("open app any way"),
            backgroundColor: Colors.teal,
            onPressed: () {
              FlutterOverlayWindow.closeOverlay();
            }),
        body: const Center(
          child: Center(
            child: Text(
              "You can do better, instead of using social media !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
