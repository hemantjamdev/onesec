import 'package:flutter/material.dart';
import 'package:usage_stats/usage_stats.dart';

class UsageData extends StatefulWidget {
  const UsageData({Key? key}) : super(key: key);

  @override
  State<UsageData> createState() => _UsageDataState();
}

class _UsageDataState extends State<UsageData> {
  List<EventUsageInfo> events = [];
  List<UsageInfo> usageStats = [];

  getUsage() async {
    DateTime endDate = new DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    UsageStats.grantUsagePermission();

    bool? isPermission = await UsageStats.checkUsagePermission();
    events = await UsageStats.queryEvents(startDate, endDate);
    usageStats = await UsageStats.queryUsageStats(startDate, endDate);
  }

  @override
  void initState() {
    getUsage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.grey[100],
                title: Text(events[index].packageName??""),
                subtitle: Text(usageStats[index].firstTimeStamp??""),
              ),
            );
          }),
    );
  }
}
