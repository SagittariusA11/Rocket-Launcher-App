

class RocketListInventory {
  final String country;
  final String firstFlight;
  final String company;
  final String rocketName;
  final String stages;

  RocketListInventory({
    required this.rocketName,
    required this.country,
    required this.firstFlight,
    required this.company,
    required this.stages,
  });

  factory RocketListInventory.fromJson(Map<String, dynamic> json) {
    return RocketListInventory(
      rocketName: json['name'],
      firstFlight: json['first_flight'],
      company: json['company'],
      country: json['country'],
      stages: json['stages'].toString(),
    );
  }
}

class StarlinkListInventory {
  final String velocity;
  final String launchDate;
  final String height;
  final String satName;
  final String site;

  StarlinkListInventory({
    required this.satName,
    required this.velocity,
    required this.launchDate,
    required this.height,
    required this.site,
  });

  factory StarlinkListInventory.fromJson(Map<String, dynamic> json) {
    return StarlinkListInventory(
      satName: json['spaceTrack']["OBJECT_NAME"],
      launchDate: json['spaceTrack']['LAUNCH_DATE'],
      height: json['height_km'].toString(),
      velocity: json['velocity_kms'].toString(),
      site: json['spaceTrack']['SITE'],
    );
  }
}