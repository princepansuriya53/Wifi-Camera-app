import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen8.dart';

class Select_camera_Type extends StatefulWidget {
  const Select_camera_Type({super.key});

  @override
  State<Select_camera_Type> createState() => _Select_camera_TypeState();
}

class _Select_camera_TypeState extends State<Select_camera_Type> {
  List<String> cameraType = [
    "Home Out 1080p",
    "IHome insight Smart 1080p",
    "Doorbell WI-FI record",
    "Scope 1080p HD Smart",
    "ROTO Smart Indoor",
    "Smart Outdoor Auto-Tracking",
    "Sentinel 1080p Pan & Till",
  ];
  String? selectedcamera;
  late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;
  BannerAd? bannerAd;
  var adUnit;
  bool _B_AdLoaded = false;
  @override
  void initState() {
    super.initState();
    bannerad();
    _initAd();
  }

  void bannerad() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdunitIt.Bannerads,
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

  void _initAd() {
    InterstitialAd.load(
      adUnitId: AdunitIt.InterstrialAds,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: _onAdLoaded,
        onAdFailedToLoad: (error) {
          Timer(
            Duration(seconds: 2),
            () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => device_Conectivity()));
            },
          );
        },
      ),
    );
  }

  void _onAdLoaded(InterstitialAd ad) {
    setState(() {
      _interstitialAd = ad;
      _isAdLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Camera Type'),
      ),
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cameraType.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      title: Text(
                        cameraType[index],
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                      trailing: Radio<String>(
                          activeColor: Colors.blue,
                          value: cameraType[index],
                          groupValue: selectedcamera,
                          onChanged: (value) =>
                              setState(() => selectedcamera = value)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40.h,
              width: 150.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    backgroundColor: Colors.blueAccent),
                onPressed: () {
                  if (_isAdLoaded) {
                    _interstitialAd.show().then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => device_Conectivity()),
                          ),
                        );
                  }
                },
                child: Text('Next',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                        color: Colors.white)),
              ),
            ),
            SizedBox(height: 21.h),
            _B_AdLoaded
                ? SizedBox(
                    height: 50.h,
                    width: bannerAd?.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd!))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
