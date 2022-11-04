import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphqldemo/models/launch.dart';
import 'package:graphqldemo/models/rocket.dart';

class SpaceXAPI {
  final HttpLink httpLink = HttpLink(
    'https://api.spacex.land/graphql/',
  );

  Future<List<Launch>> getLaunchs({int limit = 5}) async {
    // final AuthLink authLink = AuthLink(
    //   getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // );

    // final Link link = authLink.concat(httpLink);

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    const String queryString = r"""
    query ($limit: Int!){
      launchesPast(limit: $limit) {
        id
        mission_name
        launch_date_unix
        launch_site {
          site_name
        }
        links {
          article_link
          video_link
        }
        rocket {
          rocket_name
          rocket {
            wikipedia
          }
          rocket_type
        }
      }
    }""";

    final QueryOptions queryOptions = QueryOptions(
      document: gql(queryString),
      variables: <String, dynamic>{
        "limit": limit,
      },
    );

    final QueryResult result = await client.query(queryOptions);

    if (result.hasException) {
      debugPrint(result.exception.toString());
    } else {
      final List launchesData = result.data!["launchesPast"];
      return launchesData
          .map(
            (e) => Launch(
              id: e["id"],
              missionName: e["mission_name"],
              siteName: e["launch_site"]["site_name"],
              articleLink: e["links"]["article_link"] ??
                  "https://spaceflightnow.com/404",
              videoLink: e["links"]["video_link"],
              launchDateUnix: e["launch_date_unix"],
              rocket: Rocket(
                e["rocket"]["rocket_name"],
                e["rocket"]["rocket_type"],
                e["rocket"]["rocket"]["wikipedia"],
              ),
            ),
          )
          .toList();
    }
    return [];
  }
}
