import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wifi_hd_camera_app/Firebase/Remote_config.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({super.key});

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  BannerAd? bannerAd;
  bool _B_AdLoaded = false;
  var adUnit;
  @override
  void initState() {
    super.initState();
    bannerad();
  }

  void bannerad() {
    bannerAd = BannerAd(
      size: AdSize.largeBanner,
      adUnitId: adUnit = Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _B_AdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print(error);
      }),
      request: const AdRequest(),
    );
    bannerAd?.load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 0.8.h),
          const Spacer(),
          _B_AdLoaded
              ? SizedBox(
                  height: bannerAd?.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd!))
              : const SizedBox(),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class initAd extends StatelessWidget {
  initAd({Key? key}) : super(key: key) {
    _initAd();
  }

  late InterstitialAd _interstitialAd;
  bool _isAdload = false;
  void _initAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: OnAdloded,
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  void OnAdloded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdload = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADs'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_isAdload) {
                  _interstitialAd.show();
                }
              },
              child: const Text('ON Add'),
            ),
          ),
        ],
      ),
    );
  }
}

class AdunitIt {
  static String Bannerads = Config.banner_ads;

  //"ca-app-pub-3940256099942544/6300978111";
  static String InterstrialAds =
      Config.InterstrialAds; // "ca-app-pub-3940256099942544/1033173712";
}
