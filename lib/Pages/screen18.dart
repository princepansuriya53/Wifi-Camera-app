import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen19.dart';

class Camera_place extends StatefulWidget {
  const Camera_place({super.key});

  @override
  State<Camera_place> createState() => _Camera_placeState();
}

class _Camera_placeState extends State<Camera_place> {
  List<String> Place = [
    "Office",
    "Home",
    "Hotel",
    "Reception",
    "Bad Room",
    "Living Room",
    "Kitchen",
    "Guest Room",
  ];
  String? selected_place;
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
          setState(() => _B_AdLoaded = true);
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        }),
        request: const AdRequest());
    bannerAd?.load();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Where to Place Camera')),
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Place.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => features()));
                        },
                        title: Text(Place[index],
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    );
                  }),
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
