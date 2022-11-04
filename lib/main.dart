import 'package:flutter/material.dart';
import 'package:graphqldemo/models/launch.dart';
import 'package:graphqldemo/services/spacex_api.dart';
import 'package:graphqldemo/ui/launch_listview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Past Launches',
      home: Scaffold(
        appBar: AppBar(title: const Text("SpaceX Past Launches")),
        body: const LaunchesFuture(),
      ),
    );
  }
}

class LaunchesFuture extends StatefulWidget {
  const LaunchesFuture({super.key});

  @override
  State<LaunchesFuture> createState() => _LaunchesFutureState();
}

class _LaunchesFutureState extends State<LaunchesFuture> {
  late Future<List<Launch>> _future;

  @override
  void initState() {
    super.initState();
    _future = SpaceXAPI().getLaunchs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Launch>>(
      future: _future,
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
          case ConnectionState.active:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasData) {
              return LaunchListView(launchList: snapshot.data!);
            }
            return Container();
        }
      }),
    );
  }
}
