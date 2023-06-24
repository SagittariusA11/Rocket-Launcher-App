import 'dart:convert';
import 'package:http/http.dart' as http;

import '../view models/homeViewModels/launchViewModel.dart';

class LaunchService {

  static Future<List<UpcomingLaunch>> fetchUpcomingLaunches() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches/upcoming'));
    if (response.statusCode == 200) {
      final launchesJson = json.decode(response.body) as List<dynamic>;
      final futures = <Future>[];

      for (final launchJson in launchesJson) {
        final rocketId = launchJson['rocket'];
        final launchPadId = launchJson['launchpad'];
        final future = ExtractNamesAndDetails().extractRocketAndLaunchPadNames(rocketId, launchPadId)
            .then((rnlpName) {
          launchJson['rocket'] = rnlpName[0];
          launchJson['launchpad'] = rnlpName[1];
        });
        futures.add(future);
      }

      await Future.wait(futures);

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
      final futures = <Future>[];

      for (final launchJson in launchesJson) {
        final rocketId = launchJson['rocket'];
        final launchPadId = launchJson['launchpad'];
        final future = ExtractNamesAndDetails().extractRocketAndLaunchPadNames(rocketId, launchPadId)
            .then((rnlpName) {
          launchJson['rocket'] = rnlpName[0];
          launchJson['launchpad'] = rnlpName[1];
        });
        futures.add(future);
      }

      await Future.wait(futures);

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
      final futures = <Future>[];

      for (final launchJson in launchesJson) {
        final rocketId = launchJson['rocket'];
        final launchPadId = launchJson['launchpad'];
        final future = ExtractNamesAndDetails().extractRocketAndLaunchPadNames(rocketId, launchPadId)
            .then((rnlpName) {
          launchJson['rocket_01'] = rnlpName[0];
          launchJson['launchpad_01'] = rnlpName[1];
        });
        futures.add(future);
      }
      for (final launchJson in launchesJson) {
        final payloadId = launchJson['payloads'][0];
        final launchPadId = launchJson['launchpad'];
        final future = ExtractNamesAndDetails().extractNamesAndDetails(
            launchPadId,
            payloadId
        ).then((namesAndDetails) {
          launchJson['launchPadDetails'] = [
            namesAndDetails[0][0],
            namesAndDetails[0][1]
          ];
          if(namesAndDetails[1].length != 0){
            launchJson['payloads'] = [
              namesAndDetails[1][0],
              namesAndDetails[1][1],
              namesAndDetails[1][2],
              namesAndDetails[1][3]
            ];
          } else{
            launchJson['payloads'] = [];
          }
        });
        futures.add(future);
      }

      await Future.wait(futures);

      final launches = launchesJson.map((json) => AllLaunch.fromJson(json)).toList();
      return launches;
    } else {
      throw Exception('Failed to fetch all launches.');
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
