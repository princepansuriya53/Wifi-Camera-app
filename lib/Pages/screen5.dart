import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen6.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
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
                        builder: (context) => AllDevice_category()));
              },
            );
          },
        ));
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
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                      child: Image.network(
                          'https://img1.exportersindia.com/product_images/bc-full/2023/11/11275590/cctv-camera-1670996065-6671562.jpg',
                          height: 130)))
            ]),
            SizedBox(height: 10.h),
            const Text(
              "ADD Your Device",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5.h),
            Container(
              margin: const EdgeInsets.only(left: 50, right: 50),
              child: const Text(
                  "Select Your Device with different type of new camera and home security",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify),
            ),
            SizedBox(height: 21.h),
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
                                  builder: (context) => AllDevice_category())),
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
            SizedBox(height: 10.h),
            _B_AdLoaded
                ? SizedBox(
                    height: 50.h,
                    width: bannerAd?.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd!))
                : const SizedBox(),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
