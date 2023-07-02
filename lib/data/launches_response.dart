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
        final futureUpcoming = ExtractNamesAndDetails().extractRocketAndLaunchPadNames(rocketId, launchPadId)
            .then((rnlpName) {
          launchJson['rocket'] = rnlpName[0];
          launchJson['launchpad'] = rnlpName[1];
        });
        futuresUpcoming.add(futureUpcoming);
      }

      await Future.wait(futuresUpcoming);

      final launches = launchesJson.map((json) => UpcomingLaunch.fromJson(json)).toList();
      return launches;
    } else {
      throw Exception('Failed to fetch upcoming launches.');
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
        final futurePast = ExtractNamesAndDetails().extractRocketAndLaunchPadNames(rocketId, launchPadId)
            .then((rnlpName) {
          launchJson['rocket'] = rnlpName[0];
          launchJson['launchpad'] = rnlpName[1];
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
