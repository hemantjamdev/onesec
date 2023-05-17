import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class InstallAppsList extends StatefulWidget {
  const InstallAppsList({Key? key}) : super(key: key);

  @override
  State<InstallAppsList> createState() => _InstallAppsListState();
}

class _InstallAppsListState extends State<InstallAppsList> {
  List<AppInfo> apps = <AppInfo>[];
  List<AppInfo> selectedApps = <AppInfo>[];

  getApps() async {
    apps = await InstalledApps.getInstalledApps(true, true);
    setState(() {});
  }

  @override
  void initState() {
    getApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          log("----> fab called <----");
          if (await FlutterOverlayWindow.isActive()) {
            log("----> if condition <----");
            FlutterOverlayWindow.closeOverlay();
          } else {
            log("----> else condition <----");
            FlutterOverlayWindow.showOverlay(
              //height: 200,
               // width: 200,
                overlayContent: "this is  the context",enableDrag: true
            );
          }
        },
      ),
      body: ListView.builder(
          itemCount: apps.length,
          itemBuilder: (snapshot, int index) {
            if (apps.isNotEmpty) {
              AppInfo app = apps[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: selectedApps.contains(app)
                      ? Colors.teal
                      : Colors.grey[100],
                  onTap: () {
                    setState(() {
                      selectedApps.contains(app)
                          ? selectedApps.remove(app)
                          : selectedApps.add(app);
                    });
                  },
                  title: Text(app.name ?? ""),
                  leading: CircleAvatar(
                    backgroundImage: MemoryImage(app.icon!),
                  ),
                  subtitle: Text(app.packageName ?? ""),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
