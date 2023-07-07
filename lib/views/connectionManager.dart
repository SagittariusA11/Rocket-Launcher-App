import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:rocket_launcher_app/config/screenConfig.dart';
import 'package:rocket_launcher_app/utils/routeNames.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ssh2/ssh2.dart';
import 'dart:ui' as ui;
import '../config/appTheme.dart';
import '../config/imagePaths.dart';
import '../utils/utils.dart';
import 'errorView.dart';

class ConnectionManagerView extends StatefulWidget {
  const ConnectionManagerView({Key? key}) : super(key: key);

  @override
  State<ConnectionManagerView> createState() => _ConnectionManagerViewState();
}

class _ConnectionManagerViewState extends State<ConnectionManagerView> with SingleTickerProviderStateMixin {
  Color _iconColor = Color.fromARGB(255, 74, 74, 74);
  bool isLoggedIn = false;
  bool obscurePassword = true;
  bool loaded = false;
  bool isSuccess = false;
  // bool onBoarding = false;

  TextEditingController username = TextEditingController();
  TextEditingController ipAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController portNumber = TextEditingController();
  TextEditingController numberofrigs = TextEditingController();

  bool connectionStatus = false;

  connect() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('master_ip', ipAddress.text);
    await preferences.setString('master_username', username.text);
    await preferences.setString('master_password', password.text);
    await preferences.setString('master_portNumber', portNumber.text);
    await preferences.setString('numberofrigs', numberofrigs.text);

    try {
      SSHClient client = SSHClient(
        await SSHSocket.connect(ipAddress.text, int.tryParse(portNumber.text)!.toInt()),
        // host: '${credencials['ip']}',
        // port: int.parse('${credencials['port']}'),
        username: username.text,
        onPasswordRequest: () => password.text,
      );
      // SSHClient client = SSHClient(
      //   host: ipAddress.text,
      //   port: int.tryParse(portNumber.text)!.toInt(),
      //   username: username.text,
      //   passwordOrKey: password.text,
      // );
      await client;
      showAlertDialog(translate("connection.alert"),
          '${ipAddress.text} ' + translate("connection.alert2"), true);
      setState(() {
        connectionStatus = true;
      });
      // open logos
      await LGConnection().openDemoLogos();
      await client;
    } catch (e) {
      showAlertDialog(translate("connection.alert3"),
          '${ipAddress.text} ' + translate("connection.alert4"), false);
      setState(() {
        connectionStatus = false;
      });
    }
  }

  checkConnectionStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('master_ip', ipAddress.text);
    await preferences.setString('master_password', password.text);
    await preferences.setString('master_portNumber', portNumber.text);
    await preferences.setString('numberofrigs', numberofrigs.text);

    try {
      SSHClient client = SSHClient(
        await SSHSocket.connect(ipAddress.text, int.tryParse(portNumber.text)!.toInt()),
        //   host: ipAddress.text,
        //   port: int.tryParse(portNumber.text)!.toInt(),
        username: username.text,
        onPasswordRequest: () => password.text,
      );
      // SSHClient client = SSHClient(
      //   host: ipAddress.text,
      //   port: int.tryParse(portNumber.text)!.toInt(),
      //   username: username.text,
      //   passwordOrKey: password.text,
      // );
      await client;
      setState(() {
        connectionStatus = true;
      });
      await client;
    } catch (e) {
      ErrorView();
      setState(() {
        connectionStatus = false;
      });
    }
  }

  init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ipAddress.text = preferences.getString('master_ip') ?? '';
    username.text = preferences.getString('master_username') ?? '';
    password.text = preferences.getString('master_password') ?? '';
    portNumber.text = preferences.getString('master_portNumber') ?? '';
    numberofrigs.text = preferences.getString('numberofrigs') ?? '';
    await checkConnectionStatus();
    loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().bg_color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ScreenConfig.widthPercent*27,
                  child: Row(
                    children: [
                      SizedBox(
                        width: ScreenConfig.widthPercent*1.75,
                      ),
                      Utils.images(
                          ScreenConfig.heightPercent*10,
                          ScreenConfig.heightPercent*10,
                          ImagePaths.rla_icon
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translate('connection.label_l1'),
                            style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: Utils().fontSizeMultiplier(25),
                                color: AppTheme().ht_color
                            ),
                          ),
                          Text(
                            translate('connection.label_l2'),
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: Utils().fontSizeMultiplier(15),
                              color: AppTheme().ht_color
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0, top: 50),
                  child: Text(
                    translate('connection.title'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(40),
                        fontWeight: FontWeight.bold,
                      color: AppTheme().ht_color
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenConfig.widthPercent*27,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenConfig.widthPercent*10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          translate('connection.status'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: Utils().fontSizeMultiplier(20),
                              fontWeight: FontWeight.bold,
                              color: AppTheme().ht_color
                          ),
                        ),
                        Text(
                          connectionStatus
                              ? translate('connection.connected')
                              : translate('connection.disconnected'),
                          style: TextStyle(
                              fontSize: Utils().fontSizeMultiplier(20),
                              color: AppTheme().ht_color
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
                  placeholder(
                    username,
                    TextInputType.text,
                    'lg',
                    translate('connection.mmu'),
                  ),
                  placeholder(
                    ipAddress,
                    TextInputType.number,
                    '192.168.56.113',
                    translate('connection.mmip'),
                  ),
                  placeholder(
                    portNumber,
                    TextInputType.number,
                    '22',
                    translate('connection.mmpn'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20
                    ),
                    child: Material(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme().bg_color.withAlpha(200),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40)
                            )
                        ),
                        child: TextFormField(
                          controller: password,
                          obscureText: obscurePassword,
                          style: TextStyle(
                            color: selectedAppTheme.isLightMode? AppTheme().ht_color:
                            selectedAppTheme.isDarkMode? AppTheme().ht_color:
                            selectedAppTheme.isRedMode? Color.fromARGB(
                                255, 121, 0, 0):
                            selectedAppTheme.isGreenMode? Color.fromARGB(
                                255, 3, 52, 10):
                            Color.fromARGB(255, 0, 26, 66),
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: '****',
                            hintStyle: TextStyle(
                                color: AppTheme().ht_color
                            ),
                            labelText: translate('connection.mmp'),
                            labelStyle: TextStyle(
                                color: AppTheme().ht_color
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye, color: _iconColor),
                              onPressed: () {
                                setState(
                                      () {
                                    obscurePassword = !obscurePassword;
                                    if (_iconColor ==
                                        Color.fromARGB(255, 74, 74, 74)) {
                                      _iconColor = Color(0xFF3E87F5);
                                    } else {
                                      _iconColor = Color.fromARGB(255, 74, 74, 74);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  placeholder(
                    numberofrigs,
                    TextInputType.number,
                    '3',
                    translate('connection.number'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        connect();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        primary: AppTheme().ebtn_color,
                        padding: EdgeInsets.all(15),
                        shape: StadiumBorder(),
                      ),
                      child: SizedBox(
                        width: 100,
                        child: Wrap(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            FittedBox(
                              child: Text(
                                  translate('connection.connect'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(25),
                                      color: AppTheme().ht_color,
                                    fontWeight: FontWeight.bold
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  placeholder (
      TextEditingController controller,
      TextInputType keyboardType,
      String hintText,
      String labelText,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Material(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
        ),
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme().bg_color.withAlpha(200),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
            ),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: selectedAppTheme.isLightMode? AppTheme().ht_color:
              selectedAppTheme.isDarkMode? AppTheme().ht_color:
              selectedAppTheme.isRedMode? Color.fromARGB(
                  255, 121, 0, 0):
              selectedAppTheme.isGreenMode? Color.fromARGB(
                  255, 3, 52, 10):
              Color.fromARGB(255, 0, 26, 66),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  color: AppTheme().ht_color
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: AppTheme().ht_color
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(String title, String msg, bool isSuccess) {
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
                        isSuccess
                            ? "assets/images/happy.png"
                            : "assets/images/sad.png",
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
                                  primary: ui.Color.fromARGB(
                                      255, 220, 220, 220),
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
                                            ? 'continue'
                                            : 'dismiss',
                                        style: TextStyle(
                                            fontSize: Utils().fontSizeMultiplier(20),
                                            color: Colors.black)),
                                  ],
                                ),
                              ))),
                    ]),
              ),
            ));
      },
    );
  }

}

class LGConnection {
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
			<screenXY x="0" y="0.98" xunits="fraction" yunits="fraction"/>
			<rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
			<size x="0" y="0" xunits="pixels" yunits="fraction"/>
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
}
