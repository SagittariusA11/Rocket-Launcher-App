import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

String? value = selectedAppLanguage.getMode();

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
                  fontSize: Utils().fontSizeMultiplier(20),
                  color: blackandwhite
                      ? Color.fromARGB(255, 204, 204, 204)
                      : Color.fromARGB(255, 90, 90, 90),
                  fontFamily: "GoogleSans")),
          message: Text(translate('language.selection.message'),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: Utils().fontSizeMultiplier(16),
                  color: blackandwhite
                      ? Color.fromARGB(255, 204, 204, 204)
                      : Color.fromARGB(255, 90, 90, 90),
                  fontFamily: "GoogleSans")),
          actions: <Widget>[
            CupertinoActionSheetAction(
                child: Text(translate('language.name.ar') + " 🇦🇪",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: Utils().fontSizeMultiplier(18),
                    )),
                onPressed: () {
                  changeLocale(context, "ar");
                  Navigator.of(context, rootNavigator: true).pop("ar");
                }),
            CupertinoActionSheetAction(
                child: Text(translate('language.name.ru') + " 🇷🇺",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: Utils().fontSizeMultiplier(18),
                    )),
                onPressed: () {
                  changeLocale(context, "ru");
                  Navigator.of(context, rootNavigator: true).pop("ru");
                }),
            CupertinoActionSheetAction(
                child: Text(translate('language.name.ja') + " 🇯🇵",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: Utils().fontSizeMultiplier(18),
                    )),
                onPressed: () {
                  changeLocale(context, "ja");
                  Navigator.of(context, rootNavigator: true).pop("ja");
                }),
            CupertinoActionSheetAction(
                child: Text(translate('language.name.zh') + " 🇨🇳",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: Utils().fontSizeMultiplier(18),
                    )),
                onPressed: () {
                  changeLocale(context, "zh");
                  Navigator.of(context, rootNavigator: true).pop("zh");
                }),
            CupertinoActionSheetAction(
                child: Text(translate('language.name.pt') + " 🇵🇹",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: Utils().fontSizeMultiplier(18),
                    )),
                onPressed: () {
                  changeLocale(context, "pt");
                  Navigator.of(context, rootNavigator: true).pop("pt");
                }),
            CupertinoActionSheetAction(
                child: Text(translate('language.name.sq') + " 🇦🇱",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "GoogleSans",
                      fontSize: Utils().fontSizeMultiplier(18),
                    )),
                onPressed: () {
                  changeLocale(context, "sq");
                  Navigator.of(context, rootNavigator: true).pop("sq");
                })
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

class TranslatePreferences implements ITranslatePreferences {
  static const String _selectedLocaleKey = 'selected_locale';

  @override
  Future<Locale?> getPreferredLocale() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey(_selectedLocaleKey)) return null;

    var locale = preferences.getString(_selectedLocaleKey);

    return localeFromString(locale.toString());
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_selectedLocaleKey, localeToString(locale));
  }
}
