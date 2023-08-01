
class PointModel {
  double lat;
  double lng;
  double altitude;
  String altitudeMode;
  int drawOrder;

  PointModel({
    this.drawOrder = 1,
    this.altitudeMode = 'relativeToGround',
    required this.lat,
    required this.lng,
    required this.altitude,
  });

  String get tag => '''
      <Point>
        <gx:drawOrder>$drawOrder</gx:drawOrder>
        <gx:altitudeMode>$altitudeMode</gx:altitudeMode>
        <coordinates>$lng,$lat,$altitude</coordinates>
      </Point>
    ''';

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'altitude': altitude,
      'altitudeMode': altitudeMode,
      'drawOrder': drawOrder,
    };
  }

  factory PointModel.fromMap(Map<String, dynamic> map) {
    return PointModel(
      lat: map['lat'],
      lng: map['lng'],
      altitude: map['altitude'],
      altitudeMode: map['altitudeMode'],
      drawOrder: map['drawOrder'],
    );
  }
}
