
import 'package:flutter/material.dart';
import 'custom_localizations.dart';

class LangUtils {
  static String getString(BuildContext context, String id,
      {String languageCode, String countryCode, List<Object> params}) {
    return CustomLocalizations.of(context).getString(id,languageCode: languageCode, countryCode: countryCode, params: params);
  }
}