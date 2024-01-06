import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wifi_hd_camera_app/Common/common_ad_page.dart';
import 'package:wifi_hd_camera_app/Pages/screen1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class features extends StatefulWidget {
  @override
  State<features> createState() => featuresState();
}

class featuresState extends State<features> {
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
          print(error);
        }),
        request: const AdRequest());
    bannerAd?.load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool switch1 = false;
  bool switch2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Features'), centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                _B_AdLoaded
                    ? SizedBox(
                        height: 50.h,
                        width: bannerAd?.size.width.toDouble(),
                        child: AdWidget(ad: bannerAd!))
                    : SizedBox(height: 50.h, width: 320.w),
                //Switch
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 85.h,
                      width: 150.w,
                      child: Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Motion\nDetection',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp),
                              ),
                              CupertinoSwitch(
                                  value: switch1,
                                  onChanged: (value) {
                                    switch1 = value;
                                    setState(() {});
                                  },
                                  thumbColor: CupertinoColors.white,
                                  activeColor: CupertinoColors.activeGreen),
                            ]),
                      ),
                    ),
                    //Switch
                    SizedBox(
                      height: 85.h,
                      width: 150.w,
                      child: Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Notification',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            CupertinoSwitch(
                                value: switch2,
                                onChanged: (value) {
                                  switch2 = value;
                                  setState(() {});
                                },
                                thumbColor: CupertinoColors.white,
                                activeColor: CupertinoColors.activeGreen),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                //Other Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 90.h,
                      width: 170.w,
                      child: InkWell(
                        onTap: () {
                          _showAlertDialog(context);
                        },
                        child: Card(
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset("Assets/climate.png",
                                  width: 60.w,
                                  height: 50.h,
                                  color: Colors.blueGrey,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.contain),
                              const Text('30-31\nCliamte',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 23)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                      width: 170.w,
                      child: InkWell(
                        onTap: () {
                          _showAlertDialog(context);
                        },
                        child: Card(
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset("Assets/light.png",
                                  width: 60.w,
                                  color: Colors.amber,
                                  height: 50.h,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.contain),
                              Text('3 ON\nLights',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 23.sp)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 100.h,
                  width: double.infinity.w,
                  child: InkWell(
                    onTap: () {
                      _showAlertDialog(context);
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('Assets/daymode.png',
                                color: Colors.amber,
                                height: 65.h,
                                filterQuality: FilterQuality.high),
                            SizedBox(width: 10.w),
                            Text('Morning Camera',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 100.h,
                  width: double.infinity.w,
                  child: InkWell(
                    onTap: () {
                      _showAlertDialog(context);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('Assets/night-mode.png',
                                  height: 65.h,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.contain),
                              SizedBox(width: 10.w),
                              Text('Night Camera',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                      color: Colors.black)),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('something went wrong'),
          content: SizedBox(
            height: 250.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("Assets/download.png",
                    height: 60.h,
                    width: 40.w,
                    color: Colors.blue,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain),
                SizedBox(height: 20.h),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '1. Please Check Your Internet is Working Fine\n',
                          style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                        ),
                        WidgetSpan(child: SizedBox(height: 20.h)),
                        TextSpan(
                          text: '2. Whenever Camera is Power on\n',
                          style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                        ),
                        WidgetSpan(child: SizedBox(height: 20.h)),
                        TextSpan(
                          text: '3. If your setting changer',
                          style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                        ),
                      ],
                    )),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Main_screen()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text('Try AGAIN'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
