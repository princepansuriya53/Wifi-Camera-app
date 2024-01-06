// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import '../Common/screen1_common.dart';

class Main_screen extends StatefulWidget {
  const Main_screen({super.key});

  @override
  State<Main_screen> createState() => _Main_screenState();
}

class _Main_screenState extends State<Main_screen> {
  final String url =
      'https://livetvcrickalltv.blogspot.com/2022/02/crickliv.html=';

  final String _content = "Wifi HD Camera App";
  BannerAd? bannerAd;
  bool isAdLoaded = false;
  var adUnit;

  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  void initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdunitIt.Bannerads,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isAdLoaded = true;
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

  void _shareContent() {
    Share.share(_content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70.h),
          SizedBox(
              height: 100,
              width: double.infinity.w,
              child: Card(
                elevation: 0,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('Assets/Logo.png')),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Setup Camera',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp)),
                      Text(
                          '''The Smart Camera home monitoring wifi network\ncamera guide that is simple to setup.''',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500))
                    ],
                  )
                ]),
              )),
          SizedBox(height: 30.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                backgroundColor: Colors.blueAccent),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Country_list()));
            },
            child: Text('Let\'s Start',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp)),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      _shareContent();
                    },
                    child: button().card(Images: "Assets/share.png")),
                InkWell(
                    onTap: () {
                      launchMarket();
                    },
                    child: button().card(Images: "Assets/rate.png")),
                InkWell(
                    onTap: () {
                      _launchURL(url);
                    },
                    child: button().card(Images: "Assets/pp.png")),
              ],
            ),
          ),
          const Spacer(),
          isAdLoaded
              ? SizedBox(
                  height: 90.h,
                  width: bannerAd?.size.width.toDouble(),
                  child: AdWidget(ad: bannerAd!),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchMarket() async {
    const String packageName = 'com.example.wifi_hd_camera_app';

    String url = 'market://details?id=$packageName';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to launch market app'),
        ),
      );
    }
  }
}
