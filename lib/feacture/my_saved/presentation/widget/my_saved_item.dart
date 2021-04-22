import 'package:comedy/feacture/answer_writing_prompt/data/model/answer_write_prompt_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/presentation/bloc/answer_writing_prompt_bloc.dart';
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/bloc/write_without_prompt_bloc.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/route/screen_argument_model/answer_writing_prompt_detail_arguments.dart';
import 'package:comedy/utils/route/screen_argument_model/write_without_prompt_detail_arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MySavedItem extends StatelessWidget {
  final MySavedModel mySavedModel;
  final AnswerWritingPromptBloc answerWritingPromptBloc;
  final WriteWithoutPromptBloc withoutPromptBloc;
  final VoidCallback removeDataCallBack;
  final ValueSetter<AnswerWritePromptModel> editAnswerWriteDataCallBack;
  final ValueSetter<WriteWithoutPromptModel> editFreeWriteDataCallBack;

  const MySavedItem({
    this.mySavedModel,
    this.withoutPromptBloc,
    this.answerWritingPromptBloc,
    this.removeDataCallBack,
    this.editAnswerWriteDataCallBack,
    this.editFreeWriteDataCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        if (mySavedModel.promptId != null) {
          var result = await Navigator.pushNamed(
            context,
            RouteName.answer_writing_prompt_detail,
            arguments: AnswerWritingPromptDetailScreenArguments(
              answerWritePromptModel: AnswerWritePromptModel(
                title: mySavedModel.title,
                degreeOfNotSucking: mySavedModel.degreeOfNotSucking,
                levelOfCompleteness: mySavedModel.levelOfCompleteness,
                tags: mySavedModel.tags,
                id: mySavedModel.promptId,
                answer: mySavedModel.answer,
                sampleAnswer: mySavedModel.sampleAnswer,
                question: mySavedModel.question,
              ),
              answerWritingPromptBloc: answerWritingPromptBloc,
            ),
          );
          if(result != null){
            if(result is AnswerWritePromptModel){
              editAnswerWriteDataCallBack(result);
            }else{
              removeDataCallBack();
            }
          }
        }
        else {
          var result = await Navigator.pushNamed(
              context, RouteName.write_without_prompt_detail,
              arguments: WriteWithoutPromptDetailScreenArguments(
                writeWithoutPromptModel: WriteWithoutPromptModel(
                  title: mySavedModel.title,
                  description: mySavedModel.withoutPromptDescription,
                  degreeOfSucking: mySavedModel.degreeOfNotSucking,
                  levelOfCompleteness: mySavedModel.levelOfCompleteness,
                  tags: mySavedModel.tags,
                  id: mySavedModel.withoutPromptId,
                ),
                withoutPromptBloc: withoutPromptBloc,
              ));

          if(result != null){
            if(result is WriteWithoutPromptModel){
              editFreeWriteDataCallBack(result);
            }else{
              removeDataCallBack();
            }
          }
        }
      },
      child: Card(
        elevation: 1,
        color: AppColor.white,
        shadowColor: AppColor.gry,
        margin: EdgeInsets.only(bottom: 30),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(
                title: mySavedModel.title,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  Image.asset(
                    AppIcons.ic_calendar,
                    height: 20,
                    width: 20,
                  ),
                  TextComponent(
                    title: DateFormat('dd MMM, yyyy')
                        .format(mySavedModel.createdAt),
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: AppColor.gry,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  ),
                ],
              ),
              TextComponent(
                title: mySavedModel.answer != null
                    ? mySavedModel.answer
                    : mySavedModel.withoutPromptDescription,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                textOverflow: TextOverflow.ellipsis,
                maxLine: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
