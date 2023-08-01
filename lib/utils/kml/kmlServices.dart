import 'dart:io';

import 'package:dartssh2/dartssh2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/fileServices.dart';

class KMLServices{
  _getCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ipAddress = preferences.getString('master_ip') ?? '';
    String password = preferences.getString('master_password') ?? '';
    String portNumber = preferences.getString('master_portNumber') ?? '';
    String username = preferences.getString('master_username') ?? '';
    String numberofrigs = preferences.getString('numberofrigs') ?? '';

    return {
      "ip": ipAddress,
      "pass": password,
      "port": portNumber,
      "username": username,
      "numberofrigs": numberofrigs
    };
  }

  final _fileService = FileService();
  final String _url = 'http://lg1:81';
  int screenAmount = 5;

  uploadKml(File inputFile, String filename) async {
    dynamic credentials = await _getCredentials();
    SSHClient client = SSHClient(
      await SSHSocket.connect('${credentials['ip']}', int.parse('${credentials['port']}')),
      // host: '${credentials['ip']}',
      // port: int.parse('${credentials['port']}'),
      username: '${credentials['username']}',
      onPasswordRequest: () => '${credentials['pass']}',
    );
    final pw = credentials["pass"];
    final user = credentials["username"];
    screenAmount = int.parse(credentials["numberofrigs"]);
    final sftp = await client.sftp();
    double anyKindofProgressBar;
    final file = await sftp.open('/var/www/html/$filename',
        mode: SftpFileOpenMode.create |
        SftpFileOpenMode.truncate |
        SftpFileOpenMode.write);
    var fileSize = await inputFile.length();
    await file.write(inputFile.openRead().cast(), onProgress: (progress) {
      anyKindofProgressBar = progress / fileSize;
    });
  }
}