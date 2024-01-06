import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen7.dart';

class AllDevice_category extends StatefulWidget {
  const AllDevice_category({super.key});

  @override
  State<AllDevice_category> createState() => _AllDevice_categoryState();
}

class _AllDevice_categoryState extends State<AllDevice_category> {
  List<String> device = [
    "Indoor Camera",
    "Outdoor Camera",
    "Doorbell Camera",
    "Baby Camera",
  ];

  String? selectedDevice;
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
          print(error);
        }),
        request: const AdRequest());
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
        title: const Text('All Device Category'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10),
            child: Text(
                '''Select any one, we have got a suprise for you.Do You want to see? ''',
                style: TextStyle(color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: device.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(
                      device[index],
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    trailing: Radio(
                        activeColor: Colors.blue,
                        value: device[index],
                        groupValue: selectedDevice,
                        onChanged: (value) =>
                            setState(() => selectedDevice = value)),
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
                    MaterialPageRoute(
                        builder: (context) => Select_camera_Type()));
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
                  height: 50.h,
                  width: bannerAd?.size.width.toDouble(),
                  child: AdWidget(ad: bannerAd!),
                )
              : SizedBox(height: 100.h, width: 320.w),
        ],
      ),
    );
  }
}
