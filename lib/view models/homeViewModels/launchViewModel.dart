
import 'dart:convert';
import 'package:http/http.dart' as http;

class UpcomingLaunch {
  final String missionName;
  final String launchDate;
  final String rocketName;
  final String launchPad;

  UpcomingLaunch({
    required this.rocketName,
    required this.missionName,
    required this.launchDate,
    required this.launchPad,
  });

  factory UpcomingLaunch.fromJson(Map<String, dynamic> json) {
    return UpcomingLaunch(
      rocketName: json['rocket'],
      missionName: json['name'].toString().length>14?json['name'].toString().substring(0,14):json['name'],
      launchDate: json['date_utc'].toString().substring(0,10),
      launchPad: json['launchpad'] ?? 'N/A',
    );
  }

  Future<String?> extractRocketName(String rocketID) async {
    try {
      final response = await http.get(Uri.parse("https://api.spacexdata.com/v4/rockets/$rocketID"));
      final jsonData = json.decode(response.body);
      final rocketName = jsonData['name'];
      return rocketName;
    } catch (e) {
      print('Failed to extract mission name from API response: $e');
      return null;
    }
  }
}

class PastLaunch {
  final int flightNumber;
  final String missionName;
  final String launchDate;
  final String details;

  PastLaunch({
    required this.flightNumber,
    required this.missionName,
    required this.launchDate,
    required this.details,
  });

  factory PastLaunch.fromJson(Map<String, dynamic> json) {
    return PastLaunch(
      flightNumber: json['flight_number'],
      missionName: json['mission_name'],
      launchDate: json['launch_date_local'],
      details: json['details'] ?? 'N/A',
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