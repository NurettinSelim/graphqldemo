import 'package:flutter/material.dart';
import 'package:graphqldemo/models/launch.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchCard extends StatelessWidget {
  const LaunchCard({super.key, required this.launch});
  final Launch launch;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  launch.missionName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("${launch.launchDate} | ${launch.siteName}")
              ],
            ),
            Expanded(child: Container()),
            IconButton(
              onPressed: () async {
                Uri rocketUri = Uri.parse(launch.rocket.wikipediaLink);
                if (await canLaunchUrl(rocketUri)) {
                  launchUrl(rocketUri);
                }
              },
              icon: const Icon(Icons.rocket_launch),
              tooltip: launch.rocket.name,
            ),
            IconButton(
                onPressed: () async {
                  Uri videoUri = Uri.parse(launch.videoLink);
                  if (await canLaunchUrl(videoUri)) {
                    launchUrl(videoUri);
                  }
                },
                icon: const Icon(Icons.video_collection)),
            IconButton(
                onPressed: () async {
                  Uri articleUri = Uri.parse(launch.articleLink);
                  if (await canLaunchUrl(articleUri)) {
                    launchUrl(articleUri);
                  }
                },
                icon: const Icon(Icons.open_in_new)),
          ],
        ),
      ),
    );
  }
}
