import 'package:comedy/feacture/home/presentation/widget/home_answer_writing_prompt_card.dart';
import 'package:comedy/feacture/home/presentation/widget/home_event_card_widget.dart';
import 'package:comedy/feacture/home/presentation/widget/home_write_without_prompt_card_widget.dart';
import 'package:comedy/share/widget/top_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary_blue[500],
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          TopAppBarWidget(
            title: AppString.laugh_draft,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 8,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeAnswerWritingPromptCardWidget(
                    cardClickCallback: () {},
                  ),
                  HomeWriteWithoutPromptCardWidget(
                    cardClickCallback: () {},
                  ),
                  HomeEventCardWidget(
                    cardClickCallback: () {
                      Navigator.pushNamed(context, RouteName.event_show);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
