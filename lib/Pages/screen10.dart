import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen11.dart';
import 'package:flutter/material.dart';

class Fild_view extends StatefulWidget {
  const Fild_view({super.key});

  @override
  State<Fild_view> createState() => _Fild_viewState();
}

class _Fild_viewState extends State<Fild_view> {
  List<String> Angles = ["45°", "90°", "180°"];
  String? selected_Angles;
  BannerAd? bannerAD;
  bool _IsAdload = false;
  var adunit;
  @override
  void initState() {
    bannerADs();
    super.initState();
  }

  void bannerADs() {
    bannerAD = BannerAd(
      size: AdSize.banner,
      adUnitId: AdunitIt.Bannerads,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _IsAdload = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    bannerAD?.load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'What\'s your device Field of view?',
        style: TextStyle(color: Colors.white),
      )),
      backgroundColor: Colors.blue.shade100,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Text(
                '''Choose any one, We have got a surprise for you.\n Do you want to see?''',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Angles.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(Angles[index],
                        style: const TextStyle(fontWeight: FontWeight.w400)),
                    trailing: Radio<String>(
                      activeColor: Colors.blue,
                      value: Angles[index],
                      groupValue: selected_Angles,
                      onChanged: (value) =>
                          setState(() => selected_Angles = value),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vison_type()),
                );
              },
              child: Text('Next',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                      color: Colors.white)),
            ),
          ),
          SizedBox(height: 10.h),
          _IsAdload
              ? SizedBox(
                  height: 50.h,
                  width: bannerAD?.size.width.toDouble(),
                  child: AdWidget(ad: bannerAD!),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
