import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class InstallAppsList extends StatefulWidget {
  const InstallAppsList({Key? key}) : super(key: key);

  @override
  State<InstallAppsList> createState() => _InstallAppsListState();
}

class _InstallAppsListState extends State<InstallAppsList> {
  late List<AppInfo> apps;

  getApps() async {
    apps = await InstalledApps.getInstalledApps(true, true);
  }

  @override
  void initState() {
    getApps();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Installed Apps")),
      body: ListView.builder(
          itemCount: apps.length,
          itemBuilder: (snapshot, int index) {
            if (apps.isNotEmpty) {
              AppInfo app = apps[index];
              return ListTile(
                title: Text(app.name ?? ""),
                leading: CircleAvatar(
                  backgroundImage: MemoryImage(app.icon!),
                ),
                subtitle: Text(app.packageName ?? ""),
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
