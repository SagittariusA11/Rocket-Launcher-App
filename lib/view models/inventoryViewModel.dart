

class RocketListInventory {
  final String country;
  final String firstFlight;
  final String company;
  final String rocketName;
  final String stages;
  final String rocketID;

  RocketListInventory({
    required this.rocketName,
    required this.country,
    required this.firstFlight,
    required this.company,
    required this.stages,
    required this.rocketID,
  });

  factory RocketListInventory.fromJson(Map<String, dynamic> json) {
    return RocketListInventory(
      rocketName: json['name'],
      firstFlight: json['first_flight'],
      company: json['company'],
      country: json['country'],
      stages: json['stages'].toString(),
      rocketID: json['id'],
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
    if(json['height_km'] != null && json['velocity_kms'] != null){
      return StarlinkListInventory(
        satName: json['spaceTrack']["OBJECT_NAME"],
        launchDate: json['spaceTrack']['LAUNCH_DATE'],
        height: json['height_km'].toString().substring(0,6),
        velocity: json['velocity_kms'].toString().substring(0,4),
        site: json['spaceTrack']['SITE'],
      );
    } else {
      return StarlinkListInventory(
        satName: json['spaceTrack']["OBJECT_NAME"],
        launchDate: json['spaceTrack']['LAUNCH_DATE'],
        height: "N/A",
        velocity: "N/A",
        site: json['spaceTrack']['SITE'],
      );
    }
  }
}

class RocketInfo {
  final String rocketName;
  final String des;
  final String firstFlight;
  final String height;
  final String mass;
  final String dia;
  final String ll;
  final String p_1;
  final String p_2;
  final String tw;
  final String fs_r;
  final String ss_r;
  final String fs_e;
  final String ss_e;
  final String fs_t;
  final String ss_t;
  final String fs_f;
  final String ss_f;
  final String fs_bt;
  final String ss_bt;
  final String wiki;
  final List imgs;

  RocketInfo({
    required this.rocketName,
    required this.des,
    required this.firstFlight,
    required this.height,
    required this.mass,
    required this.dia,
    required this.ll,
    required this.p_1,
    required this.p_2,
    required this.tw,
    required this.fs_r,
    required this.ss_r,
    required this.fs_e,
    required this.ss_e,
    required this.fs_t,
    required this.ss_t,
    required this.fs_f,
    required this.ss_f,
    required this.fs_bt,
    required this.ss_bt,
    required this.wiki,
    required this.imgs,
  });

  factory RocketInfo.fromJson(Map<String, dynamic> json) {
    return RocketInfo(
      rocketName: json['name'],
      firstFlight: json['first_flight'],
      height: json['height']['meters'].toString(),
      des: json['description'],
      mass: json['mass']['kg'].toString(),
      dia: json['diameter']['meters'].toString(),
      ll: json['landing_legs']['number'].toString(),
      p_1: json['engines']['propellant_1'],
      p_2: json['engines']['propellant_2'],
      tw: json['engines']['thrust_to_weight'].toString(),
      fs_r: json['first_stage']['reusable']?"Yes":"No",
      ss_r: json['second_stage']['reusable']?"Yes":"No",
      fs_e: json['first_stage']['engines'].toString(),
      ss_e: json['second_stage']['engines'].toString(),
      fs_t: json['first_stage']['thrust_sea_level']['kN'].toString(),
      ss_t: json['second_stage']['thrust']['kN'].toString(),
      fs_f: json['first_stage']['fuel_amount_tons'].toString(),
      ss_f: json['second_stage']['fuel_amount_tons'].toString(),
      fs_bt: json['first_stage']['burn_time_sec'].toString(),
      ss_bt: json['second_stage']['burn_time_sec'].toString(),
      wiki: json['wikipedia'],
      imgs: json['flickr_images'],
    );
  }
}
