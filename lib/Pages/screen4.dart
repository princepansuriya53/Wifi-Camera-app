import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen5.dart';

class Agedata extends StatefulWidget {
  const Agedata({super.key});

  @override
  State<Agedata> createState() => _AgedataState();
}

class _AgedataState extends State<Agedata> {
  List<String> ageRanges = [
    "18-25",
    "25-30",
    "31-40",
    "41-50",
    "51-60",
    "61-70",
    "71-80",
    "81-90",
    "91-100",
  ];
  String? selectedAge;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('Select your age'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 510.h,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ageRanges.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                          title: Text(ageRanges[index],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Radio(
                              activeColor: Colors.blue,
                              value: ageRanges[index],
                              groupValue: selectedAge,
                              onChanged: (value) =>
                                  setState(() => selectedAge = value))),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 1.h),
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
                      MaterialPageRoute(
                          builder: (context) => const AddDevice()));
                },
                child: Text('Next',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                        color: Colors.white)),
              ),
            ),
            SizedBox(height: 5.h),
            _B_AdLoaded
                ? SizedBox(
                    height: 40.h,
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
