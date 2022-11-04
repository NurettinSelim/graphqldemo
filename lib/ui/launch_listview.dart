import 'package:flutter/material.dart';
import 'package:graphqldemo/models/launch.dart';
import 'package:graphqldemo/ui/launch_card.dart';

class LaunchListView extends StatelessWidget {
  const LaunchListView({super.key, required this.launchList});
  final List<Launch> launchList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => LaunchCard(launch: launchList[index]),
      separatorBuilder: ((context, index) => const Divider()),
      itemCount: launchList.length,
    );
  }
}
