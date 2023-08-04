
class KMLModel {
  String name;
  String content;
  String screenOverlay;

  KMLModel({
    required this.name,
    required this.content,
    this.screenOverlay = '',
  });

  String get body => '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document>
    <name>$name</name>
    <open>1</open>
    <Folder>
      $content
      $screenOverlay
    </Folder>
  </Document>
</kml>
  ''';

//   String get body => '''
// <?xml version="1.0" encoding="UTF-8"?>
// <kml xmlns="http://www.opengis.net/kml/2.2">
//   <Document>
//       <name>Description</name>
//       <open>1</open>
//       <Folder>
//         <Style id="balloon">
//         <BalloonStyle>
//           <text><![CDATA[
//             <html>
//               <head>
//                 <style>
//                   body {
//                     font-family: 'Helvetica Neue', Arial, sans-serif;
//                     background-color: #222222;
//                     color: white;
//                     padding: 20px;
//                     line-height: 1.6;
//                   }
//                   img {
//                     max-width: 100%;
//                     border-radius: 8px;
//                     box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
//                   }
//                   table {
//                     border-collapse: collapse;
//                     width: 100%;
//                     margin-top: 15px;
//                     margin-bottom: 15px;
//                   }
//                   th, td {
//                     border: 1px solid #444444;
//                     padding: 8px;
//                     text-align: left;
//                   }
//                   th {
//                     background-color: #333333;
//                     color: #ffffff;
//                     font-weight: bold;
//                   }
//                   .small {
//                     font-size: 12px;
//                   }
//                   .big {
//                     font-size: 18px;
//                   }
//                   .title {
//                     background-color: #444444;
//                     padding: 10px;
//                     border-radius: 8px;
//                     margin-top: 20px;
//                     margin-bottom: 10px;
//                     box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
//                   }
//                   .section {
//                     margin-top: 20px;
//                     margin-bottom: 20px;
//                   }
//                   .section-title {
//                     font-size: 22px;
//                     font-weight: bold;
//                     color: #cc5500;
//                     margin-bottom: 5px;
//                   }
//                   .highlight-bg {
//                     background-color: #1c1c1c;
//                     padding: 10px;
//                     border-radius: 8px;
//                     margin-top: 10px;
//                     margin-bottom: 10px;
//                   }
//                 </style>
//               </head>
//               <body>
//                 <div class="section">
//                   <img src="https://raw.githubusercontent.com/SagittariusA11/kml-images_RLA_LiquidGalaxy_GSoC-23/main/all_logos.png" />
//                 </div>
//                 <div class="section">
//                   <h1>Mission Name</h1>
//                   <h2>Rocket Name</h2>
//                 </div>
//                 <div class="section">
//                   <div class="title">
//                     <h3>Mission Details:</h3>
//                   </div>
//                   <table>
//                     <tr>
//                       <th>Date</th>
//                       <td>2006-03-24</td>
//                     </tr>
//                     <tr>
//                       <th>Time</th>
//                       <td>2:30:00 UTC</td>
//                     </tr>
//                     <tr>
//                       <th>Launch Site</th>
//                       <td>Kwajalein Atoll</td>
//                     </tr>
//                     <tr>
//                       <th>Flight Number</th>
//                       <td>1</td>
//                     </tr>
//                     <tr>
//                       <th>Payload</th>
//                       <td>Yes</td>
//                     </tr>
//                     <tr>
//                       <th>Nationality</th>
//                       <td>Republic of the Marshall Islands</td>
//                     </tr>
//                   </table>
//                 </div>
//                 <div class="section">
//                   <div class="title">
//                     <h3>Mission Description:</h3>
//                   </div>
//                     <div class="highlight-bg">
//                     <p class="small">Engine failure at 33 seconds and loss of vehicle.</p>
//                   </div>
//                 </div>
//                 <div class="section">
//                   <div class="title">
//                     <h3>Launch Site Description:</h3>
//                   </div>
//                   <div class="highlight-bg">
//                     <p class="big">Kwajalein Atoll Omelek Island</p>
//                     <p class="small">SpaceX had tentatively planned to upgrade the launch site for use by the Falcon 9 launch vehicle. As of December 2010, the SpaceX launch manifest listed Omelek (Kwajalein) as a potential site for several Falcon 9 launches, the first in 2012, and the Falcon 9 Overview document offered Kwajalein as a launch option. In any event, SpaceX did not make the upgrades necessary to support Falcon 9 launches from the atoll and did not launch Falcon 9 from Omelek. The Site has since been abandoned by SpaceX.</p>
//                   </div>
//                 </div>
//               </body>
//             </html>
//           ]]></text>
//         </BalloonStyle>
//         <LabelStyle>
//           <scale>0</scale>
//         </LabelStyle>
//         <IconStyle>
//           <scale>0</scale>
//         </IconStyle>
//       </Style>
//       <Placemark>
//         <name>name-Balloon</name>
//         <styleUrl>#balloon-id</styleUrl>
//         <Point>
//           <gx:drawOrder>1</gx:drawOrder>
//           <gx:altitudeMode>relativeToGround</gx:altitudeMode>
//           <coordinates>-80.60405833,28.60819722,150</coordinates>
//         </Point>
//         <gx:balloonVisibility>0</gx:balloonVisibility>
//       </Placemark>
//       </Folder>
//   </Document>
// </kml>
// ''';

  static String generateBlank(String id) {
    return '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document id="$id">
  </Document>
</kml>
    ''';
  }
}
