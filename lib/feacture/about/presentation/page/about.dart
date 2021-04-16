import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/about/data/model/about_tile_model.dart';
import 'package:comedy/share/widget/top_app_bar_widget.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  final VoidCallback goToSubmitPromptTab;

  const AboutView({this.goToSubmitPromptTab});

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  List<AboutTileModel> filterList = [];

  @override
  void initState() {
    // TODO: implement initState

    filterList.add(
      AboutTileModel(
          label: AppString.submit_prompt,
          leadIcon: AppIcons.ic_submit_prompt,
          onPress: () {
            widget.goToSubmitPromptTab();
          }),
    );
    filterList.add(
      AboutTileModel(
          label: AppString.share_app,
          leadIcon: AppIcons.ic_share,
          onPress: () {}),
    );
    filterList.add(
      AboutTileModel(
        label: AppString.rate_us,
        leadIcon: AppIcons.ic_rate,
        onPress: () {},
      ),
    );
    filterList.add(
      AboutTileModel(
        label: AppString.about,
        leadIcon: AppIcons.ic_about,
        onPress: () => Navigator.pushNamed(
          context,
          RouteName.about_us,
        ),
      ),
    );
    filterList.add(
      AboutTileModel(
        label: AppString.privacy_Policy,
        leadIcon: AppIcons.ic_privacy_policy,
        onPress: () {},
      ),
    );
    filterList.add(
      AboutTileModel(
        label: AppString.contact_Us,
        leadIcon: AppIcons.ic_contact_us,
        onPress: () {},
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadBody(),
    );
  }

  Widget _loadBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TopAppBarWidget(
            title: AppString.laugh_draft,
          ),
          verticalSpace(25),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filterList.length,
              itemBuilder: (BuildContext context, int index) {
                return infoTile(
                  leadingIcon: filterList[index].leadIcon,
                  text: filterList[index].label,
                  onTap: filterList[index].onPress,
                );
              })
        ],
      ),
    );
  }

  Widget infoTile({String text, leadingIcon, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Image.asset(
              leadingIcon,
              height: 25,
              width: 25.0,
            ),
            TextComponent(
              title: text,
              textStyle: StyleUtil.formFieldTextStyle,
              margin: EdgeInsets.only(left: 10),
            ),
            Spacer(),
            Image.asset(
              AppIcons.ic_left,
              height: 25,
              width: 25.0,
            )
          ],
        ),
      ),
    );
  }
}
