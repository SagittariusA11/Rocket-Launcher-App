
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

  Future<List<dynamic>> extractNamesAndDetails(
      String? launchPadID, String? payloadID,
      ) async {
    try {
      final launchPadResponse = await http.get(Uri.parse("https://api.spacexdata.com/v4/launchpads/$launchPadID"));
      final launchPadJsonData = json.decode(launchPadResponse.body);
      String launchPadName = launchPadJsonData['name'];
      final launchPadFullName = launchPadJsonData['full_name'];
      String launchPadDes = "";
      if (launchPadName == "VAFB SLC 3W") {
        launchPadDes = translate('launchInfo_tab/lsd_01');
      } else if (launchPadName == "CCSFS SLC 40") {
        launchPadDes = translate('launchInfo_tab/lsd_02');
      } else if (launchPadName == "STLS") {
        launchPadDes = translate('launchInfo_tab/lsd_03');
      } else if (launchPadName == "Kwajalein Atoll") {
        launchPadDes = translate('launchInfo_tab/lsd_04');
      } else if (launchPadName == "VAFB SLC 4E") {
        launchPadDes = translate('launchInfo_tab/lsd_05');
      } else if (launchPadName == "KSC LC 39A") {
        launchPadDes = translate('launchInfo_tab/lsd_06');
      } else {
        launchPadDes = translate('launchInfo_tab/lsd_07');
      }

      final launchPadDetails = [
        launchPadFullName,
        launchPadDes,
      ];

      List payloadDetails = [];

      if (payloadID != null) {
        final payloadResponse = await http.get(Uri.parse("https://api.spacexdata.com/v4/payloads/$payloadID"));
        final payloadJsonData = json.decode(payloadResponse.body);

        if (payloadJsonData.containsKey('name') &&
            payloadJsonData.containsKey('customers') &&
            payloadJsonData.containsKey('nationalities') &&
            payloadJsonData.containsKey('reference_system') &&
            payloadJsonData['customers'].length != 0 &&
            payloadJsonData['nationalities'].length != 0
        ) {
          payloadDetails = [
            payloadJsonData['name'],
            payloadJsonData['customers'][0],
            payloadJsonData['nationalities'][0],
            payloadJsonData['reference_system'],
          ];
        } else {
          payloadDetails = [];
        }
      } else {
        payloadDetails = [];
      }

      return [launchPadDetails, payloadDetails];
    } catch (e) {
      print('Failed to extract names and details from API response: $e');
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
  final String nationality;
  final String customer;
  final String orbit;
  final String missionDes;
  final String launchPadFullName;
  final String launchPadDes;

  AllLaunch({
    required this.flightNumber,
    required this.payload,
    required this.nationality,
    required this.customer,
    required this.orbit,
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
    if (json['payloads'].length != 0 && json['launchPadDetails'].length != 0) {
      return AllLaunch(
        rocketName: json['rocket'],
        missionName: json['name'].toString().length > 14 ? json['name'].toString().substring(0, 14) : json['name'],
        launchDate: json['date_utc'].toString().substring(0, 10),
        launchTime: json['date_utc'].toString().substring(12, 19),
        launchPad: json['launchpad'] ?? 'N/A',
        flightNumber: json['flight_number'].toString(),
        payload: json['payloads'][0],
        nationality: json['payloads'][2],
        customer: json['payloads'][1],
        orbit: json['payloads'][3],
        missionDes: json['details'],
        launchPadFullName: json['launchPadDetails'][0],
        launchPadDes: json['launchPadDetails'][1],
      );
    } else {
      return AllLaunch(
        rocketName: json['rocket'],
        missionName: json['name'].toString().length > 14 ? json['name'].toString().substring(0, 14) : json['name'],
        launchDate: json['date_utc'].toString().substring(0, 10),
        launchTime: json['date_utc'].toString().substring(12, 19),
        launchPad: json['launchpad'] ?? 'N/A',
        flightNumber: json['flight_number'].toString(),
        payload: "N/A",
        nationality: "N/A",
        customer: "N/A",
        orbit: "N/A",
        missionDes: json['details'],
        launchPadFullName: "N/A",
        launchPadDes: "N/A",
      );
    }
  }

}