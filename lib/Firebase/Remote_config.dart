import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  static final _config = FirebaseRemoteConfig.instance;

  static const _defaultvalue = {
    "AppOpenAds": "ca-app-pub-3940256099942544/9257395921",
    "bannerads": "ca-app-pub-3940256099942544/6300978111",
    "Interstrial_ads": "ca-app-pub-3940256099942544/1033173712",
    "Show_ads": true,
  };

  static Future<void> initConfig() async {
    await _config.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 30),
    ));

    await _config.setDefaults(_defaultvalue);
    await _config.fetchAndActivate();
    log('remote Config Data:${_config.getBool("Show_ads")}');

    _config.onConfigUpdated.listen((event) async {
      await _config.activate();

      log('Updated:${_config.getBool("Show_ads")}');
    });
  }

  static bool get ShowAds => _config.getBool("Show_ads");

  //All Tyepes Ads:-
  static String get AppOpen_Ads => _config.getString("AppOpenAds");
  static String get banner_ads => _config.getString("bannerads");
  static String get InterstrialAds => _config.getString("Interstrial_ads");
}
