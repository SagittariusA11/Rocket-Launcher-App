
import 'package:dartssh2/dartssh2.dart';
import 'package:rocket_launcher_app/utils/kml/kmlServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/KMLModel.dart';
import '../../models/lookAtModel.dart';
import '../../models/screenOverlayModel.dart';
import 'fileServices.dart';

class LgService {

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

  Future<int> get logoScreen async {
    dynamic credentials = await _getCredentials();
    int sA = int.parse(credentials["numberofrigs"]);
    if (sA == 1) {
      return 1;
    }
    return (sA / 2).floor() + 2;
  }

  Future<int> get balloonScreen async {
    dynamic credentials = await _getCredentials();
    int sA = int.parse(credentials["numberofrigs"]);
    if (sA == 1) {
      return 1;
    }
    return (sA / 2).floor() + 1;
  }

  Future<void> relaunch() async {
    dynamic credentials = await _getCredentials();
    final pw = credentials["pass"];
    final user = credentials["username"];
    screenAmount = int.parse(credentials["numberofrigs"]);

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credentials['ip']}', int.parse('${credentials['port']}')),
      // host: '${credentials['ip']}',
      // port: int.parse('${credentials['port']}'),
      username: '${credentials['username']}',
      onPasswordRequest: () => '${credentials['pass']}',
    );

    for (var i = screenAmount; i >= 1; i--) {
      try {
        final relaunchCommand = """RELAUNCH_CMD="\\
if [ -f /etc/init/lxdm.conf ]; then
  export SERVICE=lxdm
elif [ -f /etc/init/lightdm.conf ]; then
  export SERVICE=lightdm
else
  exit 1
fi
if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
  echo $pw | sudo -S service \\\${SERVICE} start
else
  echo $pw | sudo -S service \\\${SERVICE} restart
fi
" && sshpass -p $pw ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""";

        await client
            .execute("'/home/$user/bin/lg-relaunch' > /home/$user/log.txt");

        await client.execute(relaunchCommand);
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future<void> reboot() async {
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

    for (var i = screenAmount; i >= 1; i--) {
      try {
        await client
            .execute('sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S reboot"');

        //OR:   .execute("'/home/$user/bin/lg-reboot' > /home/$user/log.txt");
        //OR:   'sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S reboot"'
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future<void> shutdown() async {
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

    for (var i = screenAmount; i >= 1; i--) {
      try {
        await client.execute(
            'sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S poweroff"');

        //OR: "'/home/$user/bin/lg-poweroff' > /home/$user/log.txt"
        //OR: 'sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S poweroff"'
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future<void> setRefresh() async {
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

    const search = '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href>';
    const replace =
        '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>2<\\/refreshInterval>';
    final command =
        'echo $pw | sudo -S sed -i "s/$search/$replace/" ~/earth/kml/slave/myplaces.kml';

    final clear =
        'echo $pw | sudo -S sed -i "s/$replace/$search/" ~/earth/kml/slave/myplaces.kml';

    for (var i = 2; i <= screenAmount; i++) {
      final clearCmd = clear.replaceAll('{{slave}}', i.toString());
      final cmd = command.replaceAll('{{slave}}', i.toString());
      String query = 'sshpass -p $pw ssh -t lg$i \'{{cmd}}\'';

      try {
        await client.execute(query.replaceAll('{{cmd}}', clearCmd));
        await client.execute(query.replaceAll('{{cmd}}', cmd));
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    await reboot();
  }

  Future<void> resetRefresh() async {
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

    const search =
        '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>2<\\/refreshInterval>';
    const replace = '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href>';

    final clear =
        'echo $pw | sudo -S sed -i "s/$search/$replace/" ~/earth/kml/slave/myplaces.kml';

    for (var i = 2; i <= screenAmount; i++) {
      final cmd = clear.replaceAll('{{slave}}', i.toString());
      String query = 'sshpass -p $pw ssh -t lg$i \'$cmd\'';

      try {
        await client.execute(query);
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    await reboot();
  }

  Future<void> query(String content) async {
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
    await client.execute('echo "$content" > /tmp/query.txt');
    //await _sshData.execute('chmod 777 /tmp/query.txt && echo "$content" > /tmp/query.txt');
    //await _sshData.execute('echo "$content" > ~/query.txt');
  }

  Future<void> flyTo(LookAtModel lookAt) async {
    try {
      await query('flytoview=${lookAt.linearTag}');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> startTour(String tourName) async {
    try {
      await query('playtour=$tourName');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> stopTour() async {
    try {
      await query('exittour=true');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> sendTour(String tourKml, String tourName) async {
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
    final fileName = '$tourName.kml';
    try {
      final kmlFile = await _fileService.createFile(fileName, tourKml);

      await KMLServices().uploadKml(kmlFile, fileName);

      await client
          .execute('echo "\n$_url/$fileName" >> /var/www/html/kmls.txt');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    // await _sshData.execute(
    //     'chmod 777 /var/www/html/kmls.txt && echo "\n$_url/$fileName" >> /var/www/html/kmls.txt');
  }

  Future<void> setLogos({
    String name = 'RLA-logos',
    String content = '<name>Logos</name>',
  }) async {
    final screenOverlay = ScreenOverlayModel.logos();

    final kml = KMLModel(
      name: name,
      content: content,
      screenOverlay: screenOverlay.tag,
    );
    try {
      await sendKMLToSlave(logoScreen, kml.body);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> sendKMLToSlave(Future<int> screen, String content) async {
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

    dynamic credentials = await _getCredentials();
    SSHClient client = SSHClient(
      await SSHSocket.connect('${credentials['ip']}', int.parse('${credentials['port']}')),
      // host: '${credentials['ip']}',
      // port: int.parse('${credentials['port']}'),
      username: '${credentials['username']}',
      onPasswordRequest: () => '${credentials['pass']}',
    );

    try {
      await client
          .execute("echo '$content' > /var/www/html/kml/slave_$screen.kml");
      // await client.execute(
      //     "chmod 777 /var/www/html/kml/slave_$screen.kml && echo '$content' > /var/www/html/kml/slave_$screen.kml");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }


  Future<void> sendKml(KMLModel kml,
      {List<Map<String, String>> images = const []}) async {
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

    dynamic credentials = await _getCredentials();
    SSHClient client = SSHClient(
      await SSHSocket.connect('${credentials['ip']}', int.parse('${credentials['port']}')),
      // host: '${credentials['ip']}',
      // port: int.parse('${credentials['port']}'),
      username: '${credentials['username']}',
      onPasswordRequest: () => '${credentials['pass']}',
    );
    final fileName = '${kml.name}.kml';

    try {
      await clearKml();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    for (var img in images) {
      final image = await _fileService.createImage(img['name']!, img['path']!);
      String imageName = img['name']!;
      try {
        await KMLServices().uploadKml(image, imageName);
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
    try {
      final kmlFile = await _fileService.createFile(fileName, kml.body);
      await KMLServices().uploadKml(kmlFile, fileName);

      await client.execute('echo "$_url/$fileName" > /var/www/html/kmls.txt');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    // await _sshData.execute(
    //     'chmod 777 /var/www/html/kmls.txt && echo "$_url/$fileName" > /var/www/html/kmls.txt');
  }

  Future<void> clearKml({bool keepLogos = true}) async {
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

    dynamic credentials = await _getCredentials();
    SSHClient client = SSHClient(
      await SSHSocket.connect('${credentials['ip']}', int.parse('${credentials['port']}')),
      // host: '${credentials['ip']}',
      // port: int.parse('${credentials['port']}'),
      username: '${credentials['username']}',
      onPasswordRequest: () => '${credentials['pass']}',
    );
    String query =
        'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';
    for (var i = 2; i <= screenAmount; i++) {
      String blankKml = KMLModel.generateBlank('slave_$i');
      query += " && echo '$blankKml' > /var/www/html/kml/slave_$i.kml";
    }

    if (keepLogos) {
      final kml = KMLModel(
        name: 'RLA-logos',
        content: '<name>Logos</name>',
        screenOverlay: ScreenOverlayModel.logos().tag,
      );

      query +=
      " && echo '${kml.body}' > /var/www/html/kml/slave_$logoScreen.kml";
    }
    try {
      await client.execute(query);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}