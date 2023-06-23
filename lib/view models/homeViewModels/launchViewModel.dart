
import 'dart:convert';
import 'package:http/http.dart' as http;

class UpcomingLaunch {
  final String missionName;
  final String launchDate;
  final String launchTime;
  final String rocketName;
  final String launchPad;

  UpcomingLaunch({
    required this.rocketName,
    required this.missionName,
    required this.launchDate,
    required this.launchTime,
    required this.launchPad,
  });

  factory UpcomingLaunch.fromJson(Map<String, dynamic> json) {
    return UpcomingLaunch(
      rocketName: json['rocket'],
      missionName: json['name'].toString().length>14?json['name'].toString().substring(0,14):json['name'],
      launchDate: json['date_utc'].toString().substring(0,10),
      launchTime: json['date_utc'].toString().substring(12,19),
      launchPad: json['launchpad'] ?? 'N/A',
    );
  }
}

class ExtractRnLPName {
  Future<List<String>> extractRocketAndLaunchPadNames(String rocketID, String launchPadID) async {
    try {
      final rocketResponse = await http.get(Uri.parse("https://api.spacexdata.com/v4/rockets/$rocketID"));
      final rocketJsonData = json.decode(rocketResponse.body);
      final rocketName = rocketJsonData['name'];

      final launchPadResponse = await http.get(Uri.parse("https://api.spacexdata.com/v4/launchpads/$launchPadID"));
      final launchPadJsonData = json.decode(launchPadResponse.body);
      final launchPadName = launchPadJsonData['name'];

      return [rocketName, launchPadName];
    } catch (e) {
      print('Failed to extract rocket and launch pad names from API response: $e');
      return ['null', 'null'];
    }
  }
}



class PastLaunch {
  final String missionName;
  final String launchDate;
  final String launchTime;
  final String rocketName;
  final String launchPad;

  PastLaunch({
    required this.rocketName,
    required this.missionName,
    required this.launchDate,
    required this.launchTime,
    required this.launchPad,
  });

  factory PastLaunch.fromJson(Map<String, dynamic> json) {
    return PastLaunch(
      rocketName: json['rocket'],
      missionName: json['name'].toString().length>14?json['name'].toString().substring(0,14):json['name'],
      launchDate: json['date_utc'].toString().substring(0,10),
      launchTime: json['date_utc'].toString().substring(12,19),
      launchPad: json['launchpad'] ?? 'N/A',
    );
  }
}

class NextLaunch {
  final int flightNumber;
  final String missionName;
  final String launchDate;
  final String details;

  NextLaunch({
    required this.flightNumber,
    required this.missionName,
    required this.launchDate,
    required this.details,
  });

  factory NextLaunch.fromJson(Map<String, dynamic> json) {
    return NextLaunch(
      flightNumber: json['flight_number'],
      missionName: json['mission_name'],
      launchDate: json['launch_date_local'],
      details: json['details'] ?? 'N/A',
    );
  }
}

class LatestLaunch {
  final int flightNumber;
  final String missionName;
  final String launchDate;
  final String details;

  LatestLaunch({
    required this.flightNumber,
    required this.missionName,
    required this.launchDate,
    required this.details,
  });

  factory LatestLaunch.fromJson(Map<String, dynamic> json) {
    return LatestLaunch(
      flightNumber: json['flight_number'],
      missionName: json['mission_name'],
      launchDate: json['launch_date_local'],
      details: json['details'] ?? 'N/A',
    );
  }
}