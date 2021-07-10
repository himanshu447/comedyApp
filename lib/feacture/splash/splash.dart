import 'package:admob_flutter/admob_flutter.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {

  final AdmobBannerSize bannerSize = AdmobBannerSize.MEDIUM_RECTANGLE;

  @override
  Widget build(BuildContext context) {
   //_navigateToNextScreen(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            //blue circle
            Positioned(
              bottom: -30,
              left: -30,
              child: CircleAvatar(
                radius: 85,
                backgroundColor: AppColor.primary_blue[500],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppIcons.ic_splash_icon,
                  scale: 1.6,
                ),
                Container(
                //  margin: EdgeInsets.only(top: 40),
                 /* height: 250,
                  width: 300,*/
                  //color: AppColor.gry,
                  child: AdmobBanner(
                    adSize: bannerSize,
                    adUnitId: ConstantUtil.getBannerAdUnitId(),
                    onBannerCreated: (AdmobBannerController controller) {
                      // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                      // Normally you don't need to worry about disposing this yourself, it's handled.
                      // If you need direct access to dispose, this is your guy!
                      // controller.dispose();
                    },
                  ),
                )
              ],
            ),

            //orange circle
            Positioned(
              top: 10,
              right: -60,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColor.primary_orange[500],
              ),
            ),

            //pink circle
            Positioned(
              top: MediaQuery.of(context).size.width / 2,
              left: -40,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColor.primary_pink[500],
              ),
            ),

            //green circle
            Positioned(
              bottom: MediaQuery.of(context).size.height / 4,
              right: -40,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: AppColor.primary_green[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToNextScreen(BuildContext context) {
    Future.delayed(
      Duration(seconds: 5),
    ).then(
      (value) => Navigator.of(context).popAndPushNamed(RouteName.landing),
    );
  }
}
