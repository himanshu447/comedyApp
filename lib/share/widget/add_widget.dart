import 'package:admob_flutter/admob_flutter.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:flutter/material.dart';

class ShowAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: 50,
        child: AdmobBanner(
          adUnitId: ConstantUtil.getBannerAdUnitId(),
          adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
          onBannerCreated:
              (AdmobBannerController controller) {
            // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
            // Normally you don't need to worry about disposing this yourself, it's handled.
            // If you need direct access to dispose, this is your guy!
            // controller.dispose();
          },
        ),
      ),
    );
  }

}
