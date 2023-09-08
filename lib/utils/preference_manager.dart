import 'dart:async';

import 'package:progress_practical/utils/preference_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  //Singleton instance
  PreferenceManager._internal();

  static PreferenceManager instance = PreferenceManager._internal();
  static SharedPreferences? _prefs;

  factory PreferenceManager() {
    return instance;
  }

  Future<void> clearAll() async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs?.clear();
  }

  //type
  Future<String> getType() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString(PreferenceConstants.type) ?? '';
  }
  Future<void> setType(String type) async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs?.setString(PreferenceConstants.type, type);
  }

  //number
  Future<String> getNumber() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString(PreferenceConstants.number) ?? '';
  }
  Future<void> setNumber(String number) async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs?.setString(PreferenceConstants.number, number);
  }

  //country
  Future<String> getCountry() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString(PreferenceConstants.country) ?? '';
  }
  Future<void> setCountry(String country) async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs?.setString(PreferenceConstants.country, country);
  }

  //step
  Future<int> getStep() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getInt(PreferenceConstants.step) ?? 0;
  }
  Future<void> setStep(int step) async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs?.setInt(PreferenceConstants.step, step);
  }


}
