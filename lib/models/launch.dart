import 'package:graphqldemo/models/rocket.dart';
import 'package:intl/intl.dart';

class Launch {
  Launch({
    required this.id,
    required this.missionName,
    required this.siteName,
    required this.articleLink,
    required this.videoLink,
    required this.launchDateUnix,
    required this.rocket,
  });

  final String id;
  final String missionName;
  final String siteName;
  final String articleLink;
  final String videoLink;
  final int launchDateUnix;
  final Rocket rocket;

  String get launchDate {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(launchDateUnix * 1000);
    return DateFormat('dd/MM/yyyy, HH:mm').format(dt);
  }
}
