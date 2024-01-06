import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wifi_hd_camera_app/Firebase/Remote_config.dart';

class AppOpenAdManager {
  AppOpenAd? myAppOpenAd;

  loadAppOpenAd() {
    AppOpenAd.load(
        adUnitId: Config.AppOpen_Ads,
        // "ca-app-pub-3940256099942544/9257395921",
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad) {
              myAppOpenAd = ad;
              myAppOpenAd!.show();
            },
            onAdFailedToLoad: (error) {}),
        orientation: AppOpenAd.orientationPortrait);
  }
}
