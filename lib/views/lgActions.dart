import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocket_launcher_app/config/imagePaths.dart';
import 'package:rocket_launcher_app/config/screenConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssh2/ssh2.dart';
import 'package:path_provider/path_provider.dart';

import '../kml/kml.dart';
import '../utils/utils.dart';

class LGActionsView extends StatefulWidget {
  const LGActionsView({Key? key}) : super(key: key);

  @override
  State<LGActionsView> createState() => _LGActionsViewState();
}

String kmltext = "";
String localpath = "";
bool isOpen = false;
String projectname = "";

class _LGActionsViewState extends State<LGActionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenConfig.width,
        height: ScreenConfig.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePaths.lg_tasks_bg),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  Utils.images(
                      ScreenConfig.heightPercent*10,
                      ScreenConfig.heightPercent*10,
                      ImagePaths.rla_icon
                  ),
                  SizedBox(
                    width: ScreenConfig.widthPercent*2,
                  ),
                  Text(
                    "Liquid Galaxy Tasks",
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ScreenConfig.widthPercent*60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenConfig.heightPercent*5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: ScreenConfig.widthPercent*10,
                      ),
                      TaskButton(
                        task: 'Clean Logo',
                        onPressed: () async {
                          LGConnection().cleanlogos();
                        },
                      ),
                      SizedBox(
                        width: ScreenConfig.widthPercent*5,
                      ),
                      TaskButton(
                        task: 'Clean KML',
                        onPressed: () async {
                          LGConnection().cleanVisualization();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenConfig.heightPercent*5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: ScreenConfig.widthPercent*10,
                      ),
                      TaskButton(
                        task: 'Restart LG',
                        onPressed: () {
                          LGConnection().rebootLG().then((value) {
                            setState(() {
                              isOpen = false;
                            });
                          });
                        },
                      ),
                      SizedBox(
                        width: ScreenConfig.widthPercent*5,
                      ),
                      TaskButton(
                        task: 'Relaunch LG',
                        onPressed: () {
                          LGConnection().relaunchLG().then((value) {
                            setState(() {
                              isOpen = false;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenConfig.heightPercent*5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: ScreenConfig.widthPercent*10,
                      ),
                      TaskButton(
                        task: 'Shut Down LG',
                        onPressed: () {
                          LGConnection().shutdownLG().then((value) {
                            setState(() {
                              isOpen = false;
                            });
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  static Widget TaskButton (
      {required String task,
      Function? onPressed}
      ) {
    return ElevatedButton(
      onPressed: () {
        onPressed;
      },
      style: ElevatedButton.styleFrom(
        elevation: 10,
        shadowColor: Colors.grey,
        primary: Color.fromARGB(255, 62, 130, 232),
        padding: EdgeInsets.all(15),
        shape: StadiumBorder(),
      ),
      child: SizedBox(
        width: ScreenConfig.widthPercent*20,
        height: ScreenConfig.widthPercent*20*0.3,
        child: Center(
          child: Text(
              task,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              )),
        ),
      ),
    );
  }
}

class LGConnection {
  Future cleanVisualization() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      host: '${credencials['ip']}',
      port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      passwordOrKey: '${credencials['pass']}',
    );

    try {
      await client.connect();
      stopOrbit();
      return await client.execute('> /var/www/html/kmls.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  Future cleanlogos() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      host: '${credencials['ip']}',
      port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      passwordOrKey: '${credencials['pass']}',
    );
    int rigs = 4;
    String blank = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document>
  </Document>
</kml>''';
    rigs = (int.parse(credencials['numberofrigs']) / 2).floor() + 2;
    try {
      await client.connect();
      return await client
          .execute("echo '$blank' > /var/www/html/kml/slave_$rigs.kml");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future relaunchLG() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      host: '${credencials['ip']}',
      port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      passwordOrKey: '${credencials['pass']}',
    );

    try {
      for (var i = int.parse(credencials['numberofrigs']); i >= 1; i--) {
        await client.connect();
        final relaunchCommand = """RELAUNCH_CMD="\\
if [ -f /etc/init/lxdm.conf ]; then
  export SERVICE=lxdm
elif [ -f /etc/init/lightdm.conf ]; then
  export SERVICE=lightdm
else
  exit 1
fi
if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
  echo ${credencials['pass']} | sudo -S service \\\${SERVICE} start
else
  echo ${credencials['pass']} | sudo -S service \\\${SERVICE} restart
fi
" && sshpass -p ${credencials['pass']} ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""";
        await client.execute(
            '"/home/${credencials['username']}/bin/lg-relaunch" > /home/${credencials['username']}/log.txt');
        await client.execute(relaunchCommand);
      }
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  Future shutdownLG() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      host: '${credencials['ip']}',
      port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      passwordOrKey: '${credencials['pass']}',
    );

    try {
      for (var i = int.parse(credencials['numberofrigs']); i >= 1; i--) {
        await client.connect();
        await client.execute(
            'sshpass -p ${credencials['pass']} ssh -t lg$i "echo ${credencials['pass']} | sudo -S poweroff"');
      }
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  Future rebootLG() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      host: '${credencials['ip']}',
      port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      passwordOrKey: '${credencials['pass']}',
    );

    try {
      for (var i = int.parse(credencials['numberofrigs']); i >= 1; i--) {
        await client.connect();
        await client.execute(
            'sshpass -p ${credencials['pass']} ssh -t lg$i "echo ${credencials['pass']} | sudo -S reboot"'
          // "'/home/${credencials['username']}/bin/lg-reboot' > /home/${credencials['username']}/log.txt"
        );
      }
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

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

  stopOrbit() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      host: '${credencials['ip']}',
      port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      passwordOrKey: '${credencials['pass']}',
    );

    try {
      await client.connect();
      return await client.execute('echo "exittour=true" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

}
