import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen4.dart';

class gender extends StatefulWidget {
  @override
  State<gender> createState() => _genderState();
}

class _genderState extends State<gender> {
  String? selectedgender;

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

  late InterstitialAd _interstitialAd;
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
                  context, MaterialPageRoute(builder: (context) => Agedata()));
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
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(elevation: 3, title: const Text('Gender')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              child: ListTile(
                title: const Text("Male",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Radio(
                  activeColor: Colors.blue,
                  value: "1",
                  groupValue: selectedgender,
                  onChanged: (value) {
                    setState(() => selectedgender = value);
                  },
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: const Text("Female",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Radio(
                    activeColor: Colors.blue,
                    toggleable: true,
                    value: "2",
                    groupValue: selectedgender,
                    onChanged: (value) {
                      setState(() => selectedgender = value);
                    }),
              ),
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
                                  builder: (context) => Agedata())),
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
