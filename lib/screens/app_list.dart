import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:usage_stats/usage_stats.dart';

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

  getUsageForApp() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(minutes: 3));

    Map<String, UsageInfo> appIds =
        await UsageStats.queryAndAggregateUsageStats(startDate, endDate);
    log("-------length before --------");
    log(appIds.length.toString());
    List<String> keys = appIds.keys.toList();
    for (String id in keys) {
      for (var element in selectedApps) {
        if (id != element.packageName) {
          appIds.remove(id);
        } else {
          log("------added this id $id----");
        }
      }
    }
    log("-------length after --------");
    log(appIds.length.toString());
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
          getUsageForApp();
          /* log("----> fab called <----");
          if (await FlutterOverlayWindow.isActive()) {
            log("----> if condition <----");
            FlutterOverlayWindow.closeOverlay();
          } else {
            log("----> else condition <----");
            FlutterOverlayWindow.showOverlay(
                overlayContent: "this is  the context", enableDrag: true);
          }*/
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
