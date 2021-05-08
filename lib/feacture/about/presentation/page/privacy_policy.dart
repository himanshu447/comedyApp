import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SubModuleAppBarWidget(
            color: AppColor.primary_blue[500],
            title: 'Privacy Policy',
            titleTextStyle:  StyleUtil.appBarTextStyle.copyWith(
              color: AppColor.white,
            ),
            backIconColor: AppColor.white,
            actionWidget: Container(
              width: 50,
            ),
          ),
          Expanded(
            child: WebView(
              initialUrl: 'https://www.laughdraft.com/privacy-policy',
            ),
          )
        ],
      ),
    );
  }
}
