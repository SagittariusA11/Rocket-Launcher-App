
class LineModel{
  String id;
  List<Map<String, double>> coordinates;
  double drawOrder;
  String altitudeMode;

  LineModel({
    required this.id,
    required this.coordinates,
    this.drawOrder = 0,
    this.altitudeMode = 'relativeToGround',
  });


  String get tag => '''
      <Polygon id="$id">
        <extrude>0</extrude>
        <altitudeMode>$altitudeMode</altitudeMode>
        <outerBoundaryIs>
          <LinearRing>
            <coordinates>
              $linearCoordinates
            </coordinates>
          </LinearRing>
        </outerBoundaryIs>
      </Polygon>
    ''';


  String get linearCoordinates {
    String coords = coordinates
        .map((coord) => '${coord['lng']},${coord['lat']},${coord['altitude']}')
        .join(' ');

    return coords;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coordinates': coordinates,
      'altitudeMode': altitudeMode,
      'drawOrder': drawOrder,
    };
  }

  factory LineModel.fromMap(Map<String, dynamic> map) {
    return LineModel(
      id: map['id'],
      coordinates: map['coordinates'],
      altitudeMode: map['altitudeMode'],
      drawOrder: map['drawOrder'],
    );
  }
}
