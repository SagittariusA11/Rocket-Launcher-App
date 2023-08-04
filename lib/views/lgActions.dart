
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rocket_launcher_app/config/appTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ssh2/ssh2.dart';
import 'dart:io';
import 'dart:ui' as ui;

import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../main.dart';
import '../utils/utils.dart';

class LGActionsView extends StatefulWidget {
  LGActionsView({Key? key}) : super(key: key);

  @override
  State<LGActionsView> createState() => _LGActionsView();
}

bool isOpen = false;

class _LGActionsView extends State<LGActionsView> with SingleTickerProviderStateMixin {
  showAlertDialog(
      String title, String msg, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 3),
            child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 33, 33, 33),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.asset(
                        isSuccess ? "assets/images/happy.png" : "assets/images/sad.png",
                        width: 250,
                        height: 250,
                      )),
                  Text(
                    '$title',
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(25),
                      color: Color.fromARGB(255, 204, 204, 204),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 320,
                height: 180,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('$msg',
                          style: TextStyle(
                            fontSize: Utils().fontSizeMultiplier(18),
                            color: Color.fromARGB(
                              255,
                              204,
                              204,
                              204,
                            ),
                          ),
                          textAlign: TextAlign.center),
                      SizedBox(
                          width: 300,
                          child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  shadowColor: Colors.black,
                                  primary:
                                  ui.Color.fromARGB(255, 220, 220, 220),
                                  padding: EdgeInsets.all(15),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Wrap(
                                  children: <Widget>[
                                    Text(
                                        isSuccess
                                            ? translate('abox.continue')
                                            : translate('abox.dismiss'),
                                        style: TextStyle(
                                            fontSize: Utils().fontSizeMultiplier(20),
                                            color: Colors.black
                                        )
                                    ),
                                  ],
                                ),
                              ))),
                    ]),
              ),
            ));
      },
    );
  }

  showThinkDialog(
      String title, String msg, String operation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 3),
            child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 33, 33, 33),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.asset("assets/images/sure.png",
                          width: 250,
                          height: 250,
                          opacity: AlwaysStoppedAnimation<double>(0.8))),
                  Text(
                    '$title',
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(25),
                      color: Color.fromARGB(255, 204, 204, 204),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 320,
                height: 180,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('$msg',
                          style: TextStyle(
                            fontSize: Utils().fontSizeMultiplier(18),
                            color: Color.fromARGB(
                              255,
                              204,
                              204,
                              204,
                            ),
                          ),
                          textAlign: TextAlign.center),
                      SizedBox(
                          width: 300,
                          child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  shadowColor: Colors.black,
                                  primary:
                                  ui.Color.fromARGB(255, 220, 220, 220),
                                  padding: EdgeInsets.all(15),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () {
                                  if (operation == "Relaunch") {
                                    LGConnection().relaunchLG().then((value) {
                                      setState(() {
                                        isOpen = false;
                                      });
                                    }).catchError((onError) {
                                      print('oh no $onError');
                                      showAlertDialog(
                                          "alert5",
                                          "alert6",
                                          false);
                                    });
                                  } else if (operation == "Reboot") {
                                    LGConnection().rebootLG().then((value) {
                                      setState(() {
                                        isOpen = false;
                                      });
                                    }).catchError((onError) {
                                      print('oh no $onError');
                                      showAlertDialog(
                                          "alert5",
                                          "alert6",
                                          false);
                                    });
                                  } else if (operation == "Shutdown") {
                                    LGConnection().shutdownLG().then((value) {
                                      setState(() {
                                        isOpen = false;
                                      });
                                    }).catchError((onError) {
                                      print('oh no $onError');
                                      showAlertDialog(
                                          "alert5",
                                          "alert6",
                                          false);
                                    });
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Wrap(
                                  children: <Widget>[
                                    Text(translate('tbox.yes'),
                                        style: TextStyle(
                                            fontSize: Utils().fontSizeMultiplier(20),
                                            color: Colors.black
                                        )
                                    ),
                                  ],
                                ),
                              ))),
                      SizedBox(
                          width: 300,
                          child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  shadowColor: Colors.black,
                                  side: BorderSide(
                                    width: 3,
                                    color:
                                    ui.Color.fromARGB(255, 125, 164, 243),
                                  ),
                                  primary: Colors.transparent,
                                  padding: EdgeInsets.all(15),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Wrap(
                                  children: <Widget>[
                                    Text(translate('tbox.no'),
                                        style: TextStyle(
                                          fontSize: Utils().fontSizeMultiplier(20),
                                          color: Color.fromARGB(
                                              255, 125, 164, 243),
                                        )),
                                  ],
                                ),
                              ))),
                    ]),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: ScreenConfig.width,
          height: ScreenConfig.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    selectedAppTheme.isLightMode? ImagePaths.lg_tasks_bg_light:
                    selectedAppTheme.isDarkMode? ImagePaths.lg_tasks_bg_dark:
                    selectedAppTheme.isRedMode? ImagePaths.lg_tasks_bg_red:
                    selectedAppTheme.isGreenMode? ImagePaths.lg_tasks_bg_green:
                    ImagePaths.lg_tasks_bg_blue,
                  ),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          translate('tasks.LG_tasks'),
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: Utils().fontSizeMultiplier(30),
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          connectionStatus
                              ? translate('connection.connected')
                              : translate('connection.disconnected'),
                          style: TextStyle(
                              fontSize: Utils().fontSizeMultiplier(20),
                              color: Colors.white
                          ),
                        ),
                        connectionStatus
                            ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        )
                            : Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
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
                        ElevatedButton(
                          onPressed: () {
                            LGConnection()
                                .cleanlogos()
                                .catchError((onError) {
                              print('oh no $onError');
                              if (onError == 'nogeodata') {
                                showAlertDialog(
                                    'Track.alert',
                                    'Track.alert2',
                                    false,
                                );
                              }
                              showAlertDialog(
                                  'Track.alert3',
                                  'Track.alert4',
                                  false,
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().menu_bg_color,
                            padding: EdgeInsets.all(15),
                            shape: StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*20,
                            height: ScreenConfig.widthPercent*20*0.3,
                            child: Center(
                              child: Text(
                                  translate('tasks.Logo'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(30),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            LGConnection()
                                .cleanVisualization()
                                .then((value) {
                              LGConnection().cleanBalloon();
                              setState(() {
                                isOpen = false;
                              });
                            }).catchError((onError) {
                              print('oh no $onError');
                              showAlertDialog(
                                  "Tasks.alert5",
                                  "Tasks.alert6",
                                  false,
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().menu_bg_color,
                            padding: EdgeInsets.all(15),
                            shape: StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*20,
                            height: ScreenConfig.widthPercent*20*0.3,
                            child: Center(
                              child: Text(
                                  translate('tasks.Clean'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(30),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),
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
                        ElevatedButton(
                          onPressed: () {
                            LGConnection().openDemoLogos();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().menu_bg_color,
                            padding: EdgeInsets.all(15),
                            shape: StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*20,
                            height: ScreenConfig.widthPercent*20*0.3,
                            child: Center(
                              child: Text(
                                  translate('tasks.ShowLogo'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(30),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showThinkDialog(
                                translate('tasks.LGRelaunch'),
                                translate('tasks.sure'),
                                translate('tasks.Relaunch'));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().menu_bg_color,
                            padding: EdgeInsets.all(15),
                            shape: StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*20,
                            height: ScreenConfig.widthPercent*20*0.3,
                            child: Center(
                              child: Text(
                                  translate('tasks.LGRelaunch'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(30),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),
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
                        ElevatedButton(
                          onPressed: () {
                            showThinkDialog(
                                translate('tasks.LGReboot'),
                                translate('tasks.sure'),
                                translate('tasks.Reboot'));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().menu_bg_color,
                            padding: EdgeInsets.all(15),
                            shape: StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*20,
                            height: ScreenConfig.widthPercent*20*0.3,
                            child: Center(
                              child: Text(
                                  translate('tasks.LGReboot'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(30),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showThinkDialog(
                                translate('tasks.LGShutdown'),
                                translate('tasks.sure'),
                                translate('tasks.Shutdown'));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().menu_bg_color,
                            padding: EdgeInsets.all(15),
                            shape: StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*20,
                            height: ScreenConfig.widthPercent*20*0.3,
                            child: Center(
                              child: Text(
                                  translate('tasks.LGShutdown'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(30),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),
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

}

class LGConnection {
  Future cleanVisualization() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      await client;
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
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
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
      await client;
      return await client
          .execute("echo '$blank' > /var/www/html/kml/slave_$rigs.kml");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future openDemoLogos() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );
    int rigs = 4;
    rigs = (int.parse(credencials['numberofrigs']) / 2).floor() + 2;
    String openLogoKML = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>VolTrac</name>
	<open>1</open>
	<description>The logo it located in the bottom left hand corner</description>
	<Folder>
		<name>tags</name>
		<Style>
			<ListStyle>
				<listItemType>checkHideChildren</listItemType>
				<bgColor>00ffffff</bgColor>
				<maxSnippetLines>2</maxSnippetLines>
			</ListStyle>
		</Style>
		<ScreenOverlay id="abc">
			<name>VolTrac</name>
			<Icon>
				<href>https://raw.githubusercontent.com/SagittariusA11/kml-images_RLA_LiquidGalaxy_GSoC-23/main/all_logos.png</href>
			</Icon>
			<overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
			<screenXY x="0.05" y="0.95" xunits="fraction" yunits="fraction"/>
			<rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
			<size x="0.6" y="0" xunits="fraction" yunits="fraction"/>
		</ScreenOverlay>
	</Folder>
</Document>
</kml>
  ''';
    try {
      await client;
      await client
          .execute("echo '$openLogoKML' > /var/www/html/kml/slave_$rigs.kml");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future relaunchLG() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      for (var i = int.parse(credencials['numberofrigs']); i >= 1; i--) {
        await client;
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
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      for (var i = int.parse(credencials['numberofrigs']); i >= 1; i--) {
        await client;
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
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      for (var i = int.parse(credencials['numberofrigs']); i >= 1; i--) {
        await client;
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
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      await client;
      return await client.execute('echo "exittour=true" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  Future cleanBalloon() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );
    int rigs = 3;
    String blank = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document>
  </Document>
</kml>''';
    rigs = (int.parse(credencials['numberofrigs']) / 2).floor() + 1;
    try {
      await client;
      return await client
          .execute("echo '$blank' > /var/www/html/kml/slave_$rigs.kml");
    } catch (e) {
      return Future.error(e);
    }
  }
}


