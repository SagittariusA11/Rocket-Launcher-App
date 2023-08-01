class LookAtLaunch {
  double lng;
  double lat;

  LookAtLaunch(this.lng, this.lat);

  generateTag() {
    return '''
       <LookAt>
        <longitude>${this.lng}</longitude>
        <latitude>${this.lat}</latitude>
        <range>1000</range>
        <tilt>70</tilt>
        <heading>45</heading>
        <altitude>150</altitude>
        <gx:altitudeMode>relativeToGround</gx:altitudeMode>
      </LookAt>
    ''';
  }

  generateLinearString() {
    return '<LookAt><longitude>${this.lng}</longitude><latitude>${this.lat}</latitude><range>1000</range><tilt>70</tilt><heading>45</heading><altitude>150</altitude><gx:altitudeMode>relativeToGround</gx:altitudeMode></LookAt>';
  }

  toMap() {
    return {
      "lng": lng,
      "lat": lat,
    };
  }

  static fromMap(dynamic map) {
    return LookAtLaunch(
        map['lng'], map['lat']);
  }

  @override
  String toString() {
    return super.toString();
  }
}
