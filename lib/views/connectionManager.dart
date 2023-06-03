import 'package:flutter/material.dart';
import 'package:rocket_launcher_app/config/screenConfig.dart';
import 'package:rocket_launcher_app/utils/routeNames.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssh2/ssh2.dart';

import '../config/imagePaths.dart';
import '../utils/utils.dart';
import 'errorView.dart';

class ConnectionManagerView extends StatefulWidget {
  const ConnectionManagerView({Key? key}) : super(key: key);

  @override
  State<ConnectionManagerView> createState() => _ConnectionManagerViewState();
}

class _ConnectionManagerViewState extends State<ConnectionManagerView> {
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
        host: ipAddress.text,
        port: int.tryParse(portNumber.text)!.toInt(),
        username: username.text,
        passwordOrKey: password.text,
      );
      await client.connect();

      // print("Hua...");
      // print('master_ip: ${ipAddress.text}');
      // print('master_password: ${password.text}');
      // print('master_portNumber: ${portNumber.text}');
      // print('numberofrigs: ${numberofrigs.text}');
      setState(() {
        connectionStatus = true;
      });
      // open logos
      // await LGConnection().openDemoLogos();
      await client.disconnect();
    } catch (e) {
      ErrorView();
      // print("nhiHua...");
      // print('master_ip: ${ipAddress.text}');
      // print('master_password: ${password.text}');
      // print('master_portNumber: ${portNumber.text}');
      // print('numberofrigs: ${numberofrigs.text}');
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
        host: ipAddress.text,
        port: int.tryParse(portNumber.text)!.toInt(),
        username: username.text,
        passwordOrKey: password.text,
      );
      await client.connect();
      setState(() {
        connectionStatus = true;
      });
      await LGConnection().openDemoLogos();
      await client.disconnect();
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
      backgroundColor: Color.fromARGB(195, 134, 174, 217),
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
                            "Rocket Launcher App",
                            style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: 25,
                                color: Colors.black,
                            ),
                          ),
                          Text(
                            "Using Liquid Galaxy Rig",
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0, top: 50),
                  child: Text(
                    'Connection Manager',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: ScreenConfig.widthPercent*28.75,
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
                          'Status: ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          connectionStatus
                              ? 'Connected '
                              : 'Disconnected ',
                          style: TextStyle(fontSize: 20),
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.0),
                    child: Material(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(102, 139, 173, 224),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: TextFormField(
                          controller: username,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: 'lg',
                            labelText: 'Master machine Username',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 74, 74, 74)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Material(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(102, 139, 173, 224),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40)
                            )
                        ),
                        child: TextFormField(
                          controller: ipAddress,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: '192.168.56.103',
                            labelText: 'Master machine IP Address',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 74, 74, 74)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Material(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(102, 139, 173, 224),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40)
                            )
                        ),
                        child: TextFormField(
                          controller: portNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: '22',
                            labelText: 'Master machine Port Number',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 74, 74, 74)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                    ),
                    elevation: 8,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(102, 139, 173, 224),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40)
                          )
                      ),
                      child: TextFormField(
                        controller: password,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: '****',
                          labelText: 'Master machine Password',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 74, 74, 74)),
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
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Material(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(102, 139, 173, 224),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40)
                            )
                        ),
                        child: TextFormField(
                          controller: numberofrigs,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: '3',
                            labelText: 'Total Machines in the LG Rig',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 74, 74, 74)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child:
                    // onBoarding? Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         connect();
                    //         FocusManager.instance.primaryFocus?.unfocus();
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         elevation: 2,
                    //         shadowColor: Colors.grey.withOpacity(0.5),
                    //         primary: Colors.white,
                    //         padding: EdgeInsets.all(15),
                    //         shape: StadiumBorder(),
                    //       ),
                    //       child: SizedBox(
                    //         width: ScreenConfig.widthPercent*30,
                    //         child: Text(
                    //             'CONNECT',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 fontSize: 25,
                    //                 color: Colors.black,
                    //             )),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: ScreenConfig.widthPercent*10,
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.of(context).pushNamed(RouteNames.homeView);
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         elevation: 2,
                    //         shadowColor: Colors.grey.withOpacity(0.5),
                    //         primary: Colors.white,
                    //         padding: EdgeInsets.all(15),
                    //         shape: StadiumBorder(),
                    //       ),
                    //       child: SizedBox(
                    //         width: ScreenConfig.widthPercent*30,
                    //         child: Text(
                    //             'SKIP',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //               fontSize: 25,
                    //               color: Colors.black,
                    //             )),
                    //       ),
                    //     ),
                    //   ],
                    // )
                    ElevatedButton(
                      onPressed: () {
                        connect();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        primary: Colors.white,
                        padding: EdgeInsets.all(15),
                        shape: StadiumBorder(),
                      ),
                      child: SizedBox(
                        width: 100,
                        child: Wrap(
                          children: const <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            FittedBox(
                              child: Text(
                                  'CONNECT',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black
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
      host: '${credencials['ip']}',
      port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      passwordOrKey: '${credencials['pass']}',
    );
    int rigs = 4;
    rigs = (int.parse(credencials['numberofrigs']) / 2).floor() + 2;
    try {
      await client.connect();
    } catch (e) {
      return Future.error(e);
    }
  }
}
