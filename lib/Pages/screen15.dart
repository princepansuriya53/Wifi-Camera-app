import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen16.dart';

class Audio_mode extends StatefulWidget {
  const Audio_mode({super.key});

  @override
  State<Audio_mode> createState() => _Audio_modeState();
}

class _Audio_modeState extends State<Audio_mode> {
  List<String> Audio = [
    "1 Way(Single)",
    "2 Way(Both)",
  ];
  String? selected_Audio_type;
  BannerAd? bannerAd;
  var adUnit;
  bool _B_AdLoaded = false;
  @override
  void initState() {
    super.initState();
    bannerad();
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Audio mode ?')),
      backgroundColor: Colors.blue.shade100,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Text(
              '''Choose any one, We have got a surprise for you.\n Do you want to see?''',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Audio.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(Audio[index],
                        style: const TextStyle(fontWeight: FontWeight.w400)),
                    trailing: Radio<String>(
                        activeColor: Colors.blue,
                        value: Audio[index],
                        groupValue: selected_Audio_type,
                        onChanged: (value) =>
                            setState(() => selected_Audio_type = value)),
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
                    MaterialPageRoute(builder: (context) => Resolution()));
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
        ],
      ),
    );
  }
}
