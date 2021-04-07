import 'dart:math';

import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/presentation/bloc/answer_writing_prompt_bloc.dart';
import 'package:comedy/feacture/home/presentation/widget/home_answer_writing_prompt_card.dart';
import 'package:comedy/feacture/home/presentation/widget/home_event_card_widget.dart';
import 'package:comedy/feacture/home/presentation/widget/home_write_without_prompt_card_widget.dart';
import 'package:comedy/injector.dart';
import 'package:comedy/share/widget/add_widget.dart';
import 'package:comedy/share/widget/top_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/size_config.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/route/screen_argument_model/answer_writing_prompt_argument.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AnswerWritingPromptBloc answerWritingPromptBloc;

  final GlobalKey<ScaffoldState> _scKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    answerWritingPromptBloc = injector();
    answerWritingPromptBloc.add(LoadQuestionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final height = AppBar().preferredSize.height;

    return Scaffold(
      key: _scKey,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 1.5,
            padding: EdgeInsets.only(top: height + 20),
            decoration: BoxDecoration(
              color: AppColor.primary_blue[500],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 8,
            ),
            child: Column(
              children: [
                TextComponent(
                  title: AppString.laugh_draft,
                  textStyle: StyleUtil.topAppBarTextStyle,
                ),
                SizedBox(
                  height: 40,
                ),
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
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).devicePixelRatio >= 2
                        ? 0
                        : SizeConfig.blockSizeVertical * 50,
                  ),
                  child: HomeEventCardWidget(
                    cardClickCallback: () => Navigator.pushNamed(
                      context,
                      RouteName.event_show,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 2.5,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width / 4),
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
          ),*/
          Container(),
          ShowAddWidget()
        ],
      ),
    );
  }

  showAnswerWritingPromptSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
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
                    height: 120,
                  ),
                ),
                BlocBuilder<AnswerWritingPromptBloc, AnswerWritingPromptState>(
                  key: UniqueKey(),
                  cubit: answerWritingPromptBloc,
                  builder: (_, state) {
                    print(state);
                    if (state is LoadingQuestionsState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if (state is LoadedQuestionsState) {
                      return Column(
                        children: [
                          TextComponent(
                            title: state.questionAnswerModel.question,
                            textStyle: StyleUtil.calenderHeaderTextStyle,
                            textAlign: TextAlign.center,
                            margin: EdgeInsets.symmetric(
                                horizontal: 26, vertical: 12),
                          ),
                          TextComponent(
                            title: state.questionAnswerModel.sampleAnswer,
                            textStyle:
                                StyleUtil.calenderHeaderTextStyle.copyWith(
                              color: AppColor.primary_green[500],
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 26, vertical: 0),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: RawMaterialButton(
                                    onPressed: () =>
                                        Navigator.popAndPushNamed(
                                      context,
                                      RouteName.answer_writing_prompt,
                                      arguments:
                                          AnswerWritingPromptScreenArguments(
                                        questionAnswerModel:
                                            state.questionAnswerModel,
                                        answerWritingPromptBloc:
                                            answerWritingPromptBloc,
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fillColor: AppColor.primary_green[500],
                                    child: TextComponent(
                                      title: AppString.start_writing,
                                      textStyle:
                                          StyleUtil.nextButtonTextStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      answerWritingPromptBloc
                                          .add(ChangePromptEvent());
                                    },
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fillColor: AppColor.primary_green[500],
                                    child: TextComponent(
                                      title: AppString.new_prompt,
                                      textStyle:
                                          StyleUtil.nextButtonTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
