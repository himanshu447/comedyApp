import 'package:comedy/feacture/home/presentation/widget/home_answer_writing_prompt_card.dart';
import 'package:comedy/feacture/home/presentation/widget/home_event_card_widget.dart';
import 'package:comedy/feacture/home/presentation/widget/home_write_without_prompt_card_widget.dart';
import 'package:comedy/share/widget/add_widget.dart';
import 'package:comedy/share/widget/top_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopAppBarWidget(
            title: AppString.laugh_draft,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 2.5,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width/4),
              child: Column(
                children: [
                  HomeAnswerWritingPromptCardWidget(
                    cardClickCallback: () {
                      showAnswerWritingPromptSheet(context);
                    },
                  ),
                  HomeWriteWithoutPromptCardWidget(
                    cardClickCallback: () => Navigator.pushNamed(
                      context,
                      RouteName.write_without_prompt,
                    ),
                  ),
                  HomeEventCardWidget(
                    cardClickCallback: () => Navigator.pushNamed(
                      context,
                      RouteName.event_show,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(),
          ShowAddWidget()
        ],
      ),
    );
  }

  showAnswerWritingPromptSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: 50,
                  child: Divider(
                    color: AppColor.bottomBarTextColor,
                    thickness: 3,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Image.asset(
                      AppIcons.ic_close,
                      height: 22,
                    ),
                  ),
                  title: TextComponent(
                    title: AppString.answer_writing_prompts,
                    textStyle: StyleUtil.levelOfCompletenessTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    AppIcons.ic_timer,
                    height: 124,
                  ),
                ),
                TextComponent(
                  title: AppString.answer_prompt_sheet_title,
                  textStyle: StyleUtil.calenderHeaderTextStyle,
                  textAlign: TextAlign.center,
                  margin: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                ),
                TextComponent(
                  title: AppString.answer_prompt_sheet_desc,
                  textStyle: StyleUtil.calenderHeaderTextStyle.copyWith(
                    color: AppColor.primary_green[500],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () => Navigator.popAndPushNamed(
                        context,
                        RouteName.answer_writing_prompt,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: AppColor.primary_green[500],
                      child: TextComponent(
                        title: AppString.start_writing,
                        textStyle: StyleUtil.nextButtonTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () => Navigator.popAndPushNamed(
                        context,
                        RouteName.answer_writing_prompt,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: AppColor.primary_green[500],
                      child: TextComponent(
                        title: AppString.new_prompt,
                        textStyle: StyleUtil.nextButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

/*Future showPinBottomSheet({BuildContext context, String securityPin, Function onForgotPin}) async {
    bool isValidate = false;
    WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
        await showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          enableDrag: false,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          builder: (builder) {
            return WillPopScope(
              onWillPop: () async => false,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: Column(
                    children: [

                    ],
                  )
                ),
              ),
            );
          },
        );
      },
    );
  }*/
