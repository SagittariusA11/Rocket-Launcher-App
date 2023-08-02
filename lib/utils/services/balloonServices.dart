

import '../../models/balloonModel/launchBalloonModel.dart';
import '../../models/lineModel.dart';
import '../../models/lookAtModel.dart';
import '../../models/orbitModel.dart';
import '../../models/placemarkModel.dart';
import '../../models/pointModel.dart';
import '../../models/tourModel.dart';

class LaunchBalloonService {

  PlacemarkModel buildLaunchPlacemark(
      LaunchBalloonModel launch,
      double orbitPeriod, {
        LookAtModel? lookAt,
        bool updatePosition = true,
      }) {
    LookAtModel lookAtObj;

    if (lookAt == null) {
      lookAtObj = LookAtModel(
        longitude: -80.60405833,
        latitude: 28.60819722,
        range: '1000',
        tilt: '70',
        altitude: 150,
        heading: '45',
        altitudeMode: 'relativeToGround',
      );
    } else {
      lookAtObj = lookAt;
    }

    final point = PointModel(
        lat: lookAtObj.latitude,
        lng: lookAtObj.longitude,
        altitude: lookAtObj.altitude);
    final coordinates = launch.getLaunchCoordinates(step: orbitPeriod);

    final tour = TourModel(
      name: 'Launch Tour',
      placemarkId: 'p-${launch.id}',
      initialCoordinate: {
        'lat': point.lat,
        'lng': point.lng,
        'altitude': point.altitude,
      },
      coordinates: coordinates,
    );

    return PlacemarkModel(
      id: launch.id,
      name: 'Launch Statistics',
      lookAt: updatePosition ? lookAtObj : null,
      point: point,
      balloonContent: launch.balloonContent(),
      icon: 'earth.png',
      line: LineModel(
        id: launch.id,
        altitudeMode: 'absolute',
        coordinates: coordinates,
      ),
      tour: tour,
    );
  }

  String buildOrbit({LookAtModel? lookAt}) {
    LookAtModel lookAtObj;
    if (lookAt == null) {
      lookAtObj = LookAtModel(
        longitude: -80.60405833,
        latitude: 28.60819722,
        range: '1000',
        tilt: '70',
        altitude: 150,
        heading: '45',
        altitudeMode: 'relativeToGround',
      );
    } else {
      lookAtObj = lookAt;
    }

    return OrbitModel.buildOrbit(OrbitModel.tag(lookAtObj));
  }
}
