//
// import 'package:rocket_launcher_app/models/pointModel.dart';
// import 'package:rocket_launcher_app/models/tourModel.dart';
// import 'lineModel.dart';
// import 'lookAtModel.dart';
//
//
//
// class PlacemarkModel {
//
//   String id;
//   String name;
//   String? description;
//   String? icon;
//   String balloonContent;
//   bool visibility;
//   bool viewOrbit;
//   double scale;
//   LookAtModel? lookAt;
//   PointModel point;
//   LineModel line;
//   TourModel? tour;
//
//   PlacemarkModel({
//     this.description,
//     this.icon,
//     this.balloonContent = '',
//     this.visibility = true,
//     this.viewOrbit = true,
//     this.scale = 2.5,
//     this.lookAt,
//     this.tour,
//     required this.id,
//     required this.name,
//     required this.point,
//     required this.line,
//   });
//
//   String get tag => '''
//     <Style id="high-$id">
//       <IconStyle>
//         <scale>${scale + 0.5}</scale>
//         <Icon>
//           <href>http://lg1:81/$icon</href>
//         </Icon>
//         <hotSpot x="0.5" y="0.5" xunits="fraction" yunits="fraction" />
//       </IconStyle>
//     </Style>
//     <Style id="normal-$id">
//       <IconStyle>
//         <scale>$scale</scale>
//         <Icon>
//           <href>http://lg1:81/$icon</href>
//         </Icon>
//         <hotSpot x="0.5" y="0.5" xunits="fraction" yunits="fraction" />
//       </IconStyle>
//       <BalloonStyle>
//         <bgColor>ffffffff</bgColor>
//         <text><![CDATA[
//           $balloonContent
//         ]]></text>
//       </BalloonStyle>
//     </Style>
//     <Style id="line-$id">
//       <LineStyle>
//         <color>ff4444ff</color>
//         <colorMode>normal</colorMode>
//         <width>5.0</width>
//         <gx:outerColor>ff4444ff</gx:outerColor>
//         <gx:outerWidth>0.0</gx:outerWidth>
//         <gx:physicalWidth>0.0</gx:physicalWidth>
//         <gx:labelVisibility>0</gx:labelVisibility>
//       </LineStyle>
//       <PolyStyle>
//         <color>00000000</color>
//       </PolyStyle>
//     </Style>
//     <StyleMap id="$id">
//       <Pair>
//         <key>normal</key>
//         <styleUrl>normal-$id</styleUrl>
//       </Pair>
//       <Pair>
//         <key>highlight</key>
//         <styleUrl>high-$id</styleUrl>
//       </Pair>
//     </StyleMap>
//     <Placemark id="p-$id">
//       <name>$name</name>
//       <description><![CDATA[$description]]></description>
//       ${lookAt == null ? '' : lookAt!.tag}
//       <styleUrl>$id</styleUrl>
//       ${point.tag}
//       <visibility>${visibility ? 1 : 0}</visibility>
//       <gx:balloonVisibility>0</gx:balloonVisibility>
//     </Placemark>
//     ${viewOrbit ? orbitTag : ''}
//     ${tour != null ? tour!.tag : ''}
//   ''';
//
//   String get orbitTag => '''
//     <Placemark>
//       <name>Orbit - $name</name>
//       <styleUrl>line-$id</styleUrl>
//       ${line.tag}
//     </Placemark>
//   ''';
//
//   String get balloonOnlyTag => '''
//     $balloonContent
//   ''';
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description ?? '',
//       'icon': icon ?? '',
//       'visibility': visibility,
//       'viewOrbit': viewOrbit,
//       'scale': scale,
//       'balloonContent': balloonContent,
//       'lookAt': lookAt?.toMap(),
//       'point': point.toMap(),
//       'line': line.toMap(),
//       'tour': tour?.toMap(),
//     };
//   }
//
//   factory PlacemarkModel.fromMap(Map<String, dynamic> map) {
//     return PlacemarkModel(
//       id: map['id'],
//       name: map['name'],
//       description: map['description'],
//       icon: map['icon'],
//       balloonContent: map['balloonContent'],
//       visibility: map['visibility'],
//       viewOrbit: map['viewOrbit'],
//       scale: map['scale'],
//       lookAt: map['lookAt'] != null ? LookAtModel.fromMap(map['lookAt']) : null,
//       point: PointModel.fromMap(map['point']),
//       line: LineModel.fromMap(map['line']),
//       tour: map['tour'] != null ? TourModel.fromMap(map['tour']) : null,
//     );
//   }
// }
