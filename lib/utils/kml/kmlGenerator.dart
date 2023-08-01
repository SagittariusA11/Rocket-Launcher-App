import 'dart:io';

import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';

class KMLGenerator {
  static generateKML(data, filename) async {
    try {
      final downloadsDirectory = await DownloadsPath.downloadsDirectory;
      // Directory dir = Directory('/storage/emulated/0/Download');
      var savePath = (await DownloadsPath.downloadsDirectory())?.path;
      final file = File("$savePath/$filename.kml");
      await file.writeAsString(data);
      return Future.value(file);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
