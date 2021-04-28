import 'dart:io';

import 'package:comedy/feacture/answer_writing_prompt/presentation/bloc/answer_writing_prompt_bloc.dart';
import 'package:comedy/feacture/my_saved/data/model/add_tag_model.dart';
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/feacture/my_saved/data/model/short_filter_model.dart';
import 'package:comedy/feacture/my_saved/presentation/bloc/my_saved_bloc.dart';
import 'package:comedy/feacture/my_saved/presentation/widget/my_saved_item.dart';
import 'package:comedy/feacture/my_saved/presentation/widget/short_and_filter_bottom_sheet_widget.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/bloc/write_without_prompt_bloc.dart';
import 'package:comedy/injector.dart';
import 'package:comedy/share/widget/add_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/size_config.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/enum_util.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comedy/utils/extension.dart';

class MySavedView extends StatefulWidget {
  final Key key;

  const MySavedView({this.key}) : super(key: key);

  @override
  _MySavedViewState createState() => _MySavedViewState();
}

class _MySavedViewState extends State<MySavedView> {
  final TextEditingController _searchController = TextEditingController();

  List<ShortAndFilterModel> filterList = [];
  List<AddTagModel> tagList = [];
  List<String> selectedTagList = [];

  int filterResult;

  MySavedBloc mySavedBloc;

  AnswerWritingPromptBloc answerWritingPromptBloc;
  WriteWithoutPromptBloc withoutPromptBloc;

  @override
  void initState() {
    super.initState();

    mySavedBloc = injector<MySavedBloc>();
    withoutPromptBloc = injector<WriteWithoutPromptBloc>();
    answerWritingPromptBloc = injector<AnswerWritingPromptBloc>();

    mySavedBloc.add(LoadMySavedEvent());

    filterList.add(
      ShortAndFilterModel(
        label: AppString.title_a_to_z,
        isChecked: true,
      ),
    );
    filterList.add(
      ShortAndFilterModel(
        label: AppString.title_z_to_a,
        isChecked: false,
      ),
    );
    filterList.add(
      ShortAndFilterModel(
        label: AppString.date_update_newest_to_older,
        isChecked: false,
      ),
    );
    filterList.add(
      ShortAndFilterModel(
        label: AppString.date_update_older_to_newest,
        isChecked: false,
      ),
    );
    filterList.add(
      ShortAndFilterModel(
        label: AppString.level_of_completeness_highest_to_lowest,
        isChecked: false,
      ),
    );
    filterList.add(
      ShortAndFilterModel(
        label: AppString.level_of_completeness_lowest_to_highest,
        isChecked: false,
      ),
    );
    filterList.add(
      ShortAndFilterModel(
        label: AppString.degree_of_not_sucking_highest_to_lowest,
        isChecked: false,
      ),
    );
    filterList.add(
      ShortAndFilterModel(
        label: AppString.degree_of_not_sucking_lowest_to_highest,
        isChecked: false,
      ),
    );
  }

  @override
  void dispose() {
    mySavedBloc.close();
    answerWritingPromptBloc.close();
    withoutPromptBloc.close();
    super.dispose();
  }

  _saveTagFromData(List<MySavedModel> list) {
    list.forEach((saveItem) {

      if(saveItem.tags.isNotEmpty) {
        saveItem.tags.forEach((singleTag) {

          if(singleTag.isNotEmpty){
            if (singleTag
                .substring(1)
                .isNotEmpty) {
              AddTagModel addTagModel = AddTagModel(
                  isChecked: false, label: singleTag.substring(1).capitalize());

              if (!tagList.contains(addTagModel)) {
                tagList.add(addTagModel);
              }
            }
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant MySavedView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.key != widget.key) {
      print('sadsadsd');
      mySavedBloc.add(LoadMySavedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 1.5,
            padding: EdgeInsets.only(top: AppBar().preferredSize.height + 20),
            decoration: BoxDecoration(
              color: AppColor.primary_blue[500],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                TextComponent(
                  title: AppString.laugh_draft,
                  textAlign: TextAlign.center,
                  textStyle: StyleUtil.topAppBarTextStyle,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Form(
                    onChanged: () {
                      setState(() {
                        _searchController;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset(
                            AppIcons.ic_search,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              filled: false,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              hintText: AppString.search,
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              mySavedBloc.add(
                                SearchMySavedEvent(
                                  text: text,
                                ),
                              );
                            },
                          ),
                        ),
                        _searchController.text.trim().isNotEmpty
                            ? Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: AppColor.gry,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    //_searchController.clear();
                                    //mySavedBloc.add(ClearSearchListEvent());
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<MySavedBloc, MySavedState>(
            cubit: mySavedBloc,
            builder: (_, state) {
              if (state is LoadingMySavedState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedMySavedState) {
                _saveTagFromData(state.savedList);

                if (state.searchSavedList == null) {
                  return _loadBody(list: state.savedList);
                } else if (state.searchSavedList.isEmpty) {
                  return Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2.1,
                        right: 0.0,
                        left: 0.0,
                        child: Image.asset(
                          AppIcons.ic_my_save_no_result,
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ],
                  );
                } else {
                  return _loadBody(list: state.searchSavedList);
                }
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _loadBody({List<MySavedModel> list}) {
    return Stack(
      children: [
        Visibility(
          visible: list.isEmpty,
          child: Positioned(
            /*top: MediaQuery
                .of(context)
                .size
                .height / 2.1,*/
            top: SizeConfig.screenHeight / 2,
            right: 0.0,
            left: 0.0,
            child: Image.asset(
              AppIcons.ic_my_save_empty,
              height: SizeConfig.blockSizeVertical * 24,
              width: SizeConfig.blockSizeHorizontal * 50,
            ),
          ),
        ),
        Visibility(
          visible: list.isNotEmpty,
          child: Positioned.fill(
            top: SizeConfig.screenHeight > 700
                ? SizeConfig.screenHeight / 3.8
                : SizeConfig.screenHeight / 2.5,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (_, index) {
                return MySavedItem(
                  mySavedModel: list[index],
                  withoutPromptBloc: withoutPromptBloc,
                  answerWritingPromptBloc: answerWritingPromptBloc,

                  removeDataCallBack: () {
                    mySavedBloc.add(RemoveDataFromListEvent(id: list[index].id));
                  },

                  editAnswerWriteDataCallBack: (val) {


                    mySavedBloc.add(
                      EditAnswerWriteDataInListEvent(
                        id: list[index].id,
                        answerWritePromptModel: val,
                      ),
                    );
                  },

                  editFreeWriteDataCallBack: (val){

                    print(mySavedBloc.state);

                    mySavedBloc.add(
                      EditFreeWriteDataInListEvent(
                        id: list[index].id,
                        writeWithoutPromptModel: val,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        list.isEmpty
            ? ShowAddWidget()
            : Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _showShortAndFilterSheet,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                AppIcons.ic_filter,
                                height: 20,
                                width: 20,
                              ),
                              TextComponent(
                                title: AppString.sort_filter,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                              ),
                              Visibility(
                                visible: filterResult != null,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppColor.primary_blue[500],
                                  child: TextComponent(
                                    title: filterResult.toString(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: AppColor.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        Container(),
      ],
    );
  }

  _showShortAndFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      backgroundColor: AppColor.white,
      builder: (_) {
        return ShortAndFilterBottomSheetWidget(
          filterList: filterList,
          tagList: tagList,
          settingSeletedTagList: selectedTagList.isEmpty ? [] : selectedTagList,
          resultCallback: (List<String> list) {
            var filterLabel = list[0];

            List<String> tags = list.sublist(1);
            selectedTagList = tags;

            if (filterLabel == AppString.title_a_to_z) {
              mySavedBloc
                  .add(FilterListEvent(filters: Filters.aToz, tags: tags));
            } else if (filterLabel == AppString.title_z_to_a) {
              mySavedBloc
                  .add(FilterListEvent(filters: Filters.zToA, tags: tags));
            } else if (filterLabel == AppString.date_update_newest_to_older) {
              mySavedBloc.add(
                  FilterListEvent(filters: Filters.newToOldDate, tags: tags));
            } else if (filterLabel == AppString.date_update_older_to_newest) {
              mySavedBloc.add(
                  FilterListEvent(filters: Filters.oldToNewDate, tags: tags));
            } else if (filterLabel ==
                AppString.level_of_completeness_highest_to_lowest) {
              mySavedBloc.add(FilterListEvent(
                  filters: Filters.levelHighestToLowest, tags: tags));
            } else if (filterLabel ==
                AppString.level_of_completeness_lowest_to_highest) {
              mySavedBloc.add(FilterListEvent(
                  filters: Filters.levelLowestToHighest, tags: tags));
            } else if (filterLabel ==
                AppString.degree_of_not_sucking_lowest_to_highest) {
              mySavedBloc.add(FilterListEvent(
                  filters: Filters.degreeLowestToHighest, tags: tags));
            } else if (filterLabel ==
                AppString.degree_of_not_sucking_highest_to_lowest) {
              mySavedBloc.add(FilterListEvent(
                  filters: Filters.degreeHighestToLowest, tags: tags));
            }
            filterResult = list.length;
          },
        );
      },
    );
  }
}

/*top:  MediaQuery.of(context).devicePixelRatio >= 2
                ? SizeConfig.blockSizeVertical * 40
                : SizeConfig.blockSizeVertical * 20,*/
/*top: MediaQuery
                .of(context)
                .size
                .height / 3.8,*/
