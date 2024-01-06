import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen17.dart';

class Resolution extends StatefulWidget {
  const Resolution({super.key});

  @override
  State<Resolution> createState() => _ResolutionState();
}

class _ResolutionState extends State<Resolution> {
  List<String> Resolution_type = [
    "4K",
    "2K",
    "1080p",
    "720p",
    "480p",
    "360p",
    "240p",
    "144p",
  ];
  String? selected_Resolution_type;

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
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Net_conmection()));
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
      appBar: AppBar(title: const Text('Select Your Video Resolution ?')),
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Text(
                '''Choose any one, We have got a surprise for you.\n Do you want to see?''',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
                height: 450.h,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: Resolution_type.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                              title: Text(Resolution_type[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                              trailing: Radio<String>(
                                activeColor: Colors.blue,
                                value: Resolution_type[index],
                                groupValue: selected_Resolution_type,
                                onChanged: (value) => setState(
                                    () => selected_Resolution_type = value),
                              )),
                        );
                      }),
                )),
            SizedBox(
              height: 40.h,
              width: 150.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.r))),
                    backgroundColor: Colors.blueAccent),
                onPressed: () {
                  if (_isAdLoaded) {
                    _interstitialAd.show().then(
                          (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Net_conmection())),
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
                    child: AdWidget(ad: bannerAd!),
                  )
                : const SizedBox(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
