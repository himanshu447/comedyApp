import 'package:comedy/feacture/home/presentation/widget/home_answer_writing_prompt_card.dart';
import 'package:comedy/feacture/home/presentation/widget/home_event_card_widget.dart';
import 'package:comedy/feacture/home/presentation/widget/home_write_without_prompt_card_widget.dart';
import 'package:comedy/share/widget/add_widget.dart';
import 'package:comedy/share/widget/top_app_bar_widget.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/string_util.dart';
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
              child: Column(
                children: [
                  HomeAnswerWritingPromptCardWidget(
                    cardClickCallback: () {},
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
  Future showPinBottomSheet(
      {BuildContext context, String securityPin, Function onForgotPin}) async {
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
  }
}
