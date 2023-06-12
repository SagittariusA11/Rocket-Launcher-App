import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

String? value = "en";

void showDemoActionSheet(
    {required BuildContext context, required Widget child}) {
  showCupertinoModalPopup<String>(
      context: context, builder: (BuildContext context) => child);
}

void onActionSheetPress(BuildContext context, bool blackandwhite) {
  showDemoActionSheet(
      context: context,
      child: Theme(
        data: blackandwhite ? ThemeData.dark() : ThemeData.light(),
        child: CupertinoActionSheet(
          title: Text(translate('language.selection.title'),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: blackandwhite
                      ? Color.fromARGB(255, 204, 204, 204)
                      : Color.fromARGB(255, 90, 90, 90),
                  fontFamily: "GoogleSans")),
          message: Text(translate('language.selection.message'),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                  color: blackandwhite
                      ? Color.fromARGB(255, 204, 204, 204)
                      : Color.fromARGB(255, 90, 90, 90),
                  fontFamily: "GoogleSans")),
          actions: <Widget>[
            CupertinoActionSheetAction(
                child: Text(translate('language.name.en') + " 🇺🇸",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: 18.0,
                    )),
                onPressed: () {
                  changeLocale(context, "en");
                  Navigator.of(context, rootNavigator: true).pop("en");
                }),
            CupertinoActionSheetAction(
                child: Text(translate('language.name.es') + " 🇪🇸",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: 18.0,
                    )),
                onPressed: () {
                  changeLocale(context, "es");
                  Navigator.of(context, rootNavigator: true).pop("es");
                }),
            CupertinoActionSheetAction(
                child: Text(translate('language.name.hi') + " 🇮🇳",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: 18.0,
                    )),
                onPressed: () {
                  changeLocale(context, "hi");
                  Navigator.of(context, rootNavigator: true).pop("hi");
                }),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(translate('button.cancel'),
                style: TextStyle(
                    fontWeight: FontWeight.normal, fontFamily: "GoogleSans")),
            isDefaultAction: true,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop("Cancel"),
          ),
        ),
      ));
}
