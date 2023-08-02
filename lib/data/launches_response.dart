import 'dart:convert';
import 'package:http/http.dart' as http;

import '../view models/homeViewModels/launchViewModel.dart';

class LaunchService {

  static Future<List<UpcomingLaunch>> fetchUpcomingLaunches() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches/upcoming'));
    if (response.statusCode == 200) {
      final launchesJson = json.decode(response.body) as List<dynamic>;
      final futuresUpcoming = <Future>[];

      for (final launchJson in launchesJson) {
        final rocketId = launchJson['rocket'];
        final launchPadId = launchJson['launchpad'];
        final futureUpcoming = ExtractNamesAndDetails().extractNamesAndDetails(rocketId, launchPadId)
            .then((rnlpDes) {
          launchJson['rocket_01'] = rnlpDes[0];
          launchJson['country'] = rnlpDes[1];
          launchJson['company'] = rnlpDes[2];
          launchJson['launchpad'] = rnlpDes[3];
          launchJson['launchpadFM'] = rnlpDes[4];
          launchJson['launchpadDes'] = rnlpDes[5];
          launchJson['lat'] = rnlpDes[6];
          launchJson['lng'] = rnlpDes[7];
        });
        futuresUpcoming.add(futureUpcoming);
      }

      await Future.wait(futuresUpcoming);

      final launches = launchesJson.map((json) => UpcomingLaunch.fromJson(json)).toList();
      return launches;
    } else {
      print('Failed to fetch upcoming launches: ${response.statusCode}');
      return [];
    }

  }

  static Future<List<PastLaunch>> fetchPastLaunches() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches/past'));
    if (response.statusCode == 200) {
      final launchesJson = json.decode(response.body) as List<dynamic>;
      final futuresPast = <Future>[];

      for (final launchJson in launchesJson) {
        final rocketId = launchJson['rocket'];
        final launchPadId = launchJson['launchpad'];
        final futurePast = ExtractNamesAndDetails().extractNamesAndDetails(rocketId, launchPadId)
            .then((rnlpDes) {
          launchJson['rocket_01'] = rnlpDes[0];
          launchJson['country'] = rnlpDes[1];
          launchJson['company'] = rnlpDes[2];
          launchJson['launchpad'] = rnlpDes[3];
          launchJson['launchpadFM'] = rnlpDes[4];
          launchJson['launchpadDes'] = rnlpDes[5];
          launchJson['lat'] = rnlpDes[6];
          launchJson['lng'] = rnlpDes[7];
        });
        futuresPast.add(futurePast);
      }

      await Future.wait(futuresPast);

      final launches = launchesJson.map((json) => PastLaunch.fromJson(json)).toList();
      return launches;
    } else {
      throw Exception('Failed to fetch past launches.');
    }
  }

  static Future<List<AllLaunch>> fetchAllLaunches() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches'));
    if (response.statusCode == 200) {
      final launchesJson = json.decode(response.body) as List<dynamic>;
      print("1:$launchesJson");
      final futuresAll = <Future>[];

      for (final launchJson in launchesJson) {
        final rocketId = launchJson['rocket'];
        final launchPadId = launchJson['launchpad'];
        final futureAll = ExtractNamesAndDetails().extractNamesAndDetails(rocketId, launchPadId)
            .then((NnDes) {
          launchJson['rocket_01'] = NnDes[0];
          launchJson['country'] = NnDes[1];
          launchJson['company'] = NnDes[2];
          launchJson['launchpad'] = NnDes[3];
          launchJson['launchpadFM'] = NnDes[4];
          launchJson['launchpadDes'] = NnDes[5];
          launchJson['lat'] = NnDes[6];
          launchJson['lng'] = NnDes[7];
          print("\n\n2: $NnDes\n\n");
        });
        futuresAll.add(futureAll);
      }

      await Future.wait(futuresAll);
      final launches = launchesJson.map((json) => AllLaunch.fromJson(json)).toList();
      print("6: $launches");
      return launches;
    } else {
      print('Failed to fetch all launches: ${response.statusCode}');
      return [];
    }
  }

  static Future<List<dynamic>> fetchNextLaunch() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches/next'));
    if (response.statusCode == 200) {
      final launches = json.decode(response.body);
      return launches;
    } else {
      throw Exception('Failed to fetch next launch.');
    }
  }

  static Future<List<dynamic>> fetchLatestLaunch() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches/latest'));
    if (response.statusCode == 200) {
      final launches = json.decode(response.body);
      return launches;
    } else {
      throw Exception('Failed to fetch latest launch.');
    }
  }
}
