import 'dart:convert';

import 'strings_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyLocalizations {
  MyLocalizations(this.locale) {
    StringsLocation.configure(this);
  }

  final Locale locale;

  static MyLocalizations? of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  Map<String, String> _sentences = {};

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('resources/lang/${locale.languageCode}.json');
    Map<String, dynamic> result = json.decode(data);

    _sentences = {};
    result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return _sentences[key] ?? '';
  }
}
