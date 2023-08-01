import 'dart:math';

import 'package:rocket_launcher_app/models/pointModel.dart';
import 'package:rocket_launcher_app/models/tourModel.dart';

import '../../main.dart';
import '../lineModel.dart';
import '../lookAtModel.dart';


class LaunchBalloonModel {
  String id;
  String? image;
  String? missionName;
  String? rocketName;
  String? date;
  String? time;
  String? launchSite;
  bool visibility;
  bool viewOrbit;
  String? flightNumber;
  String? payload;
  String? nationality;
  String? missionDescription;
  String? launchSiteFullName;
  String? launchSiteDescription;

  LaunchBalloonModel({
    this.image,
    this.missionName,
    this.rocketName,
    this.date,
    this.time,
    this.launchSite,
    this.visibility = true,
    this.viewOrbit = true,
    this.flightNumber,
    this.payload,
    this.nationality,
    this.missionDescription,
    this.launchSiteFullName,
    this.launchSiteDescription,
    required this.id,
  });


  String balloonContent() => '''
    <description><![CDATA[
      <html>
        <head>
          <style>
            body {
              font-family: 'Helvetica Neue', Arial, sans-serif;
              background-color: #222222;
              color: white;
              padding: 20px;
              line-height: 1.6;
            }
            img {
              max-width: 100%;
              border-radius: 8px;
              box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            }
            table {
              border-collapse: collapse;
              width: 100%;
              margin-top: 15px;
              margin-bottom: 15px;
            }
            th, td {
              border: 1px solid #444444;
              padding: 8px;
              text-align: left;
            }
            th {
              background-color: #333333;
              color: #ffffff;
              font-weight: bold;
            }
            .small {
              font-size: 12px;
            }
            .big {
              font-size: 18px;
            }
            .title {
              background-color: #444444;
              padding: 10px;
              border-radius: 8px;
              margin-top: 20px;
              margin-bottom: 10px;
              box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            }
            .section {
              margin-top: 20px;
              margin-bottom: 20px;
            }
            .section-title {
              font-size: 22px;
              font-weight: bold;
              color: #cc5500;
              margin-bottom: 5px;
            }
            .highlight-bg {
              background-color: #1c1c1c;
              padding: 10px;
              border-radius: 8px;
              margin-top: 10px;
              margin-bottom: 10px;
            }
          </style>
        </head>
        <body>
          <div class="section">
            <img src=$image />
          </div>
          <div class="section">
            <h1>$missionName</h1>
            <h2>$rocketName</h2>
          </div>
          <div class="section">
            <div class="title">
              <h3>Mission Details:</h3>
            </div>
            <table>
              <tr>
                <th>Date</th>
                <td>$date</td>
              </tr>
              <tr>
                <th>Time</th>
                <td>$time</td>
              </tr>
              <tr>
                <th>Launch Site</th>
                <td>$launchSite</td>
              </tr>
              <tr>
                <th>Flight Number</th>
                <td>$flightNumber</td>
              </tr>
              <tr>
                <th>Payload</th>
                <td>$payload</td>
              </tr>
              <tr>
                <th>Nationality</th>
                <td>$nationality</td>
              </tr>
            </table>
          </div>
          <div class="section">
            <div class="title">
              <h3>Mission Description:</h3>
            </div>
              <div class="highlight-bg">
              <p class="small">$missionDescription</p>
            </div>
          </div>
          <div class="section">
            <div class="title">
              <h3>Launch Site Description:</h3>
            </div>
            <div class="highlight-bg">
              <p class="big">$launchSiteFullName</p>
              <p class="small">$launchSiteDescription</p>
            </div>
          </div>
        </body>
      </html>
    ]]></description>
  ''';

  List<Map<String, double>> getLaunchCoordinates({
    double step = 3,
    double altitude = 150,

  }) {


    List<Map<String, double>> coords = [];
    double displacement = 0;
    double spot = 0;

    while (spot < 361) {
      displacement += step / 361;

      double angle = displacement * (pi / 180.0);
      double latitude = 28.60819722;
      double longitude = -80.60405833;
      double distance = altitude;

      // Calculate the new coordinates based on the orbit parameters
      double newLatitude = latitude + distance * cos(angle) / earthRadius;
      double newLongitude = longitude +
          distance * sin(angle) / (earthRadius * cos(latitude * (pi / 180.0)));

      coords.add({
        'lat': newLatitude,
        'lng': newLongitude,
        'alt': altitude,
      });

      spot++;
    }

    return coords;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image ?? '',
      'missionName': missionName ?? '',
      'rocketName': rocketName?? '',
      'date': date??'',
      'time': time??'',
      'launchSite': launchSite??"",
      'visibility': visibility,
      'viewOrbit': viewOrbit,
      'flightNumber': flightNumber??'',
      'payload': payload??'',
      'nationality': nationality??'',
      'missionDescription': missionDescription??'',
      'launchSiteFullName': launchSiteFullName??'',
      'launchSiteDescription': launchSiteDescription??'',
    };
  }

  factory LaunchBalloonModel.fromMap(Map<String, dynamic> map) {
    return LaunchBalloonModel(
      id: map['id'],
      image: map['image'],
      rocketName: map['rocketName'],
      date: map['date'],
      time: map['time'],
      launchSite: map['launchSite'],
      visibility: map['visibility'],
      viewOrbit: map['viewOrbit'],
      flightNumber: map['flightNumber'],
      payload: map['payload'],
      nationality: map['nationality'],
      missionDescription: map['missionDescription'],
      launchSiteFullName: map['launchSiteFullName'],
      launchSiteDescription: map['launchSiteDescription'],
    );
  }
}
