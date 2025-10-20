import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LocaleService {
  static const String _localeKey = 'app_locale';

  static Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey) ?? 'vi';
    return Locale(localeCode);
  }

  static Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  static Future<void> setLocaleCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
  }

  static Future<String> getLocaleCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey) ?? 'vi';
  }
}
