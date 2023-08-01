
class LookAtModel {

  double longitude;
  double latitude;
  double altitude;
  String range;
  String tilt;
  String heading;
  String altitudeMode;

  LookAtModel(
      {required this.longitude,
        required this.latitude,
        required this.range,
        required this.tilt,
        required this.heading,
        this.altitude = 0,
        this.altitudeMode = 'relativeToGround'});

  String get tag => '''
      <LookAt>
        <longitude>$longitude</longitude>
        <latitude>$latitude</latitude>
        <altitude>$altitude</altitude>
        <range>$range</range>
        <tilt>$tilt</tilt>
        <heading>$heading</heading>
        <gx:altitudeMode>$altitudeMode</gx:altitudeMode>
      </LookAt>
    ''';

  String get linearTag =>
      '<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><altitude>$altitude</altitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><gx:altitudeMode>$altitudeMode</gx:altitudeMode></LookAt>';

  toMap() {
    return {
      'lng': longitude,
      'lat': latitude,
      'altitude': altitude,
      'range': range,
      'tilt': tilt,
      'heading': heading,
      'altitudeMode': altitudeMode
    };
  }

  factory LookAtModel.fromMap(Map<String, dynamic> map) {
    return LookAtModel(
        longitude: map['lng'],
        latitude: map['lat'],
        altitude: map['altitude'],
        range: map['range'],
        tilt: map['tilt'],
        heading: map['heading'],
        altitudeMode: map['altitudeMode']);
  }
}



