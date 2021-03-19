import 'package:comedy/feacture/my_saved/data/model/add_tag_model.dart';
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/feacture/my_saved/data/model/short_filter_model.dart';
import 'package:comedy/feacture/my_saved/presentation/bloc/my_saved_bloc.dart';
import 'package:comedy/feacture/my_saved/presentation/widget/my_saved_item.dart';
import 'package:comedy/feacture/my_saved/presentation/widget/short_and_filter_bottom_sheet_widget.dart';
import 'package:comedy/injector.dart';
import 'package:comedy/share/widget/add_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySavedView extends StatefulWidget {
  @override
  _MySavedViewState createState() => _MySavedViewState();
}

class _MySavedViewState extends State<MySavedView> {
  final TextEditingController _searchController = TextEditingController();

  List<String> list = [];
  List<ShortAndFilterModel> filterList = [];
  List<AddTagModel> tagList = [];
  List<String> selectedTagList = [];

  int filterResult;

  MySavedBloc mySavedBloc;

  @override
  void initState() {
    super.initState();

    mySavedBloc = injector<MySavedBloc>();
    mySavedBloc.add(LoadMySavedEvent());

    list = List.generate(10, (index) => 'TexTo number $index');
    tagList = List.generate(20,
        (index) => AddTagModel(label: 'Tag Number $index', isChecked: false));

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
    super.dispose();
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
                      EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppIcons.ic_search,
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                            filled: false,
                            hintText: AppString.search,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
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
                return _loadBody(list: state.savedList);
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
            top: MediaQuery.of(context).size.height / 2.1,
            right: 0.0,
            left: 0.0,
            child: Image.asset(
              AppIcons.ic_my_save_empty,
              height: 200,
              width: 200,
            ),
          ),
        ),
        Visibility(
          visible: list.isNotEmpty,
          child: Positioned(
            top: MediaQuery.of(context).size.width / 1.9,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (_, index) {
                return MySavedItem(
                  mySavedModel: list[index],
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
          resultCallback: () {
            setState(() {
              filterResult = 3;
            });
          },
        );
      },
    );
  }
}
