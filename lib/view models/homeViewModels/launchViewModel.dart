
import 'dart:convert';
import 'package:flutter_translate/flutter_translate.dart';
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

class ExtractNamesAndDetails {
  Future<List<String>> extractRocketAndLaunchPadNames(
      String rocketID, String launchPadID
      ) async {
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

  Future<List<String>> extractNamesAndDetails(
      String rocketID, String launchPadID
      ) async {
    try {
      final rocketResponse = await http.get(Uri.parse("https://api.spacexdata.com/v4/rockets/$rocketID"));
      final rocketJsonData = json.decode(rocketResponse.body);
      final rocketName = rocketJsonData['name'];
      final company = rocketJsonData['company'];
      final country = rocketJsonData['country'];

      final launchPadResponse = await http.get(Uri.parse("https://api.spacexdata.com/v4/launchpads/$launchPadID"));
      final launchPadJsonData = json.decode(launchPadResponse.body);
      final launchPadName = launchPadJsonData['name'];
      final launchPadFullName = launchPadJsonData['full_name'];
      String launchPadDes = "";
      if (launchPadName == "VAFB SLC 3W") {
        launchPadDes = '1';
      } else if (launchPadName == "CCSFS SLC 40") {
        launchPadDes = '2';
      } else if (launchPadName == "STLS") {
        launchPadDes = '3';
      } else if (launchPadName == "Kwajalein Atoll") {
        launchPadDes = '4';
      } else if (launchPadName == "VAFB SLC 4E") {
        launchPadDes = '5';
      } else if (launchPadName == "KSC LC 39A") {
        launchPadDes = '6';
      } else {
        launchPadDes = '7';
      }

      return [rocketName, country, company, launchPadName, launchPadFullName, launchPadDes];
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

class AllLaunch {
  final String missionName;
  final String launchDate;
  final String launchTime;
  final String rocketName;
  final String launchPad;
  final String flightNumber;
  final String payload;
  final String country;
  final String company;
  final String missionDes;
  final String launchPadFullName;
  final String launchPadDes;

  AllLaunch({
    required this.flightNumber,
    required this.payload,
    required this.country,
    required this.company,
    required this.missionDes,
    required this.launchPadFullName,
    required this.launchPadDes,
    required this.rocketName,
    required this.missionName,
    required this.launchDate,
    required this.launchTime,
    required this.launchPad,
  });

  factory AllLaunch.fromJson(Map<String, dynamic> json) {
    if (json['payloads'].length != 0) {
      return AllLaunch(
        rocketName: json['rocket'],
        missionName: json['name'].toString().length > 14 ? json['name'].toString().substring(0, 14) : json['name'],
        launchDate: json['date_utc'].toString().substring(0, 10),
        launchTime: json['date_utc'].toString().substring(12, 19),
        launchPad: json['launchpad'] ?? 'N/A',
        flightNumber: json['flight_number'].toString(),
        payload: 'YES',
        country: json['country'],
        company: json['company'],
        missionDes: json['details'],
        launchPadFullName: json['launchpadFM'],
        launchPadDes: json['launchpadDes'],
      );
    } else {
      return AllLaunch(
        rocketName: json['rocket'],
        missionName: json['name'].toString().length > 14 ? json['name'].toString().substring(0, 14) : json['name'],
        launchDate: json['date_utc'].toString().substring(0, 10),
        launchTime: json['date_utc'].toString().substring(12, 19),
        launchPad: json['launchpad'] ?? 'N/A',
        flightNumber: json['flight_number'].toString(),
        payload: 'NO',
        country: json['country'],
        company: json['company'],
        missionDes: json['details'],
        launchPadFullName: json['launchpadFM'],
        launchPadDes: json['launchpadDes'],
      );
    }
  }

}