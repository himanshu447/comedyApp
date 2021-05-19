import 'package:comedy/feacture/my_saved/data/model/add_tag_model.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/short_filter_select_radio_list.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:comedy/utils/extension.dart';

class AddTagBottomSheetWidget extends StatefulWidget {
  final List<AddTagModel> tagList;
  final List<String> tempList;
  final ValueSetter<List<String>> selectedTagList;

  const AddTagBottomSheetWidget({
    Key key,
    this.tagList,
    this.tempList,
    this.selectedTagList,
  }) : super(key: key);

  @override
  _AddTagBottomSheetWidgetState createState() =>
      _AddTagBottomSheetWidgetState();
}

class _AddTagBottomSheetWidgetState extends State<AddTagBottomSheetWidget> {
  final TextEditingController _searchController = TextEditingController();

  List<AddTagModel> searchTagList;

  @override
  void initState() {
    super.initState();

    /*widget.tagList.forEach((element) {
      if(element.isChecked){
        selectedTagList.add(element.label);
      }
    });*/
  }
  @override
  Widget build(BuildContext context) {

    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          color: AppColor.black,
                          size: 24,
                        ),
                      ),
                      Expanded(
                        child: TextComponent(
                          title: AppString.add_tag,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Visibility(
                        visible: widget.tempList.isNotEmpty,
                        child: FlatButton(
                          onPressed: () {
                            widget.selectedTagList(widget.tempList);
                            setState(
                              () {
                              //  selectedTagList.clear();
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: TextComponent(
                            title: AppString.done,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12).copyWith(top: 16),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColor.textFieldBgColor,
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
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                filled: false,
                                hintText: AppString.search,
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                if(text.isNotEmpty) {
                                  _searchTagFromList(text);
                                }else{
                                  _searchController.clear();
                                  _changedIsCheckFromSearch();
                                  searchTagList = null;
                                }
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
                                _searchController.clear();
                                _changedIsCheckFromSearch();
                                searchTagList = null;
                              },
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  TextComponent(
                    title: AppString.all_tag,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    margin: EdgeInsets.only(top: 12, left: 10),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height / 5.2,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchTagList == null
                        ? _buildList(widget.tagList)
                        : searchTagList.isNotEmpty
                            ? _buildList(searchTagList)
                            : Center(
                                child: TextComponent(
                                  title: 'Result not found',
                                ),
                              ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _changedIsCheckFromSearch(){

    searchTagList.forEach((element) {
      if(element.isChecked){
        var index = widget.tagList.indexWhere((tag) => tag.label == element.label);
        widget.tagList[index]  = widget.tagList[index].copyWith(isChecked: true);
      }

    });

  }

  Widget _buildList(List<AddTagModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return RadioListTitleComponent(
          isLeading: true,
          label: list[index].label,
          value: list[index],
          isChecked: list[index].isChecked == true,
          itemSelected: (val) {

            /*if (widget.tempList.isNotEmpty) {
              if (!widget.tempList.contains(val.label) && !val.isChecked) {
                widget.tempList.add(val.label);
              }else{
                widget.tempList.remove(val.label);
              }
            } else {
              widget.tempList.add(val.label);
            }

            setState(() {
              list[index] = list[index].copyWith(isChecked: !list[index].isChecked);
            });
                       */

            var ab = list.indexWhere((element) => element.isChecked == true);

            if (ab >= 0) {
              print('adasd');
              setState(() {
                list[ab] = list[ab].copyWith(isChecked: false,);
              });
            }
            setState(() {
              list[index] = list[index].copyWith(isChecked: true,);
            });

            widget.tempList.clear();
            widget.tempList.add(list.firstWhere((element) => element.isChecked).label);
          },
        );
      },
    );
  }

  _searchTagFromList(String text) {
    var newText = text.capitalize();
    var tempList = widget.tagList
        .where((element) => element.label.contains(newText))
        .toList();

    setState(() {
    searchTagList = tempList;
    });
  }
}

///for multiple selection
/*
return CheckListTitleComponent(
          label: list[index].label,
          value: list[index],
          isChecked: list[index].isChecked == true,
          itemSelected: (AddTagModel val) {

            if (widget.tempList.isNotEmpty) {
              if (!widget.tempList.contains(val.label) && !val.isChecked) {
                widget.tempList.add(val.label);
              }else{
                widget.tempList.remove(val.label);
              }
            } else {
              widget.tempList.add(val.label);
            }

            setState(() {
              list[index] = list[index].copyWith(isChecked: !list[index].isChecked);
            });
          },
        );
 */
