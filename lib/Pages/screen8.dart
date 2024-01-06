import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen9.dart';

class device_Conectivity extends StatefulWidget {
  const device_Conectivity({super.key});

  @override
  State<device_Conectivity> createState() => _device_ConectivityState();
}

class _device_ConectivityState extends State<device_Conectivity> {
  List<String> cameraType = ["Wired", "Wireless", "HardWired"];
  String? selectedcamera;
  BannerAd? bannerAd;
  var adUnit;
  bool _B_AdLoaded = false;
  @override
  void initState() {
    bannerad();
    super.initState();
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
      }),
      request: const AdRequest(),
    );
    bannerAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What\'s your device Connectivity ?'),
      ),
      backgroundColor: Colors.blue.shade100,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10),
            child: Text(
              '''Choose any one, We have got a suprise for you.\nDo you want to see?''',
              style: TextStyle(color: Colors.black),
            ),
          ),
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
                          setState(() => selectedcamera = value),
                    ),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Recordig_mode()));
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
                  height: 40.h,
                  width: bannerAd?.size.width.toDouble(),
                  child: AdWidget(ad: bannerAd!))
              : const SizedBox(),
        ],
      ),
    );
  }
}
