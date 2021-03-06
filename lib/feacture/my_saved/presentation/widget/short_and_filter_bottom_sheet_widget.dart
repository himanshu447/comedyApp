import 'package:comedy/feacture/my_saved/data/model/add_tag_model.dart';
import 'package:comedy/feacture/my_saved/data/model/short_filter_model.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/short_filter_select_radio_list.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

import 'add_tag_bottom_sheet_widget.dart';

class ShortAndFilterBottomSheetWidget extends StatefulWidget {
  final List<ShortAndFilterModel> filterList;
  final List<AddTagModel> tagList;
  final VoidCallback resultCallback;

  ShortAndFilterBottomSheetWidget({
    this.filterList,
    this.tagList,
    this.resultCallback,
  });

  @override
  _ShortAndFilterBottomSheetWidgetState createState() =>
      _ShortAndFilterBottomSheetWidgetState();
}

class _ShortAndFilterBottomSheetWidgetState
    extends State<ShortAndFilterBottomSheetWidget> {
  List<String> selectedTagList = [];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Row(
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
                      title: AppString.sort_filter,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        selectedTagList.clear();
                        var data = widget.filterList
                            .indexWhere((element) => element.isChecked);

                        if (data >= 0) {
                          widget.filterList[data] = widget.filterList[data]
                              .copyWith(isChecked: false);
                        }
                        widget.filterList.first =
                            widget.filterList.first.copyWith(isChecked: true);
                      });
                    },
                    child: TextComponent(
                      title: AppString.reset,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: 50,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextComponent(
                      title: AppString.sort,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      margin: EdgeInsets.symmetric(vertical: 12),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.filterList.length,
                      itemBuilder: (_, index) {
                        return RadioListTitleComponent(
                          label: widget.filterList[index].label,
                          itemSelected: (val) {
                            var ab = widget.filterList.indexWhere(
                                (element) => element.isChecked == true);

                            if (ab >= 0) {
                              setState(() {
                                widget.filterList[ab] =
                                    widget.filterList[ab].copyWith(
                                  isChecked: false,
                                );
                              });
                            }
                            setState(() {
                              widget.filterList[index] =
                                  widget.filterList[index].copyWith(
                                isChecked: true,
                              );
                            });
                          },
                          value: widget.filterList[index],
                          isChecked: widget.filterList[index].isChecked == true,
                        );
                      },
                    ),
                    TextComponent(
                      title: AppString.filter_by_tag,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      margin: EdgeInsets.symmetric(vertical: 12).copyWith(
                        top: 26,
                      ),
                    ),
                    Visibility(
                      visible: selectedTagList.isNotEmpty,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: 12,
                        spacing: 8,
                        children: selectedTagList
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.primary_blue[50],
                                ),
                                child: TextComponent(
                                  title: e,
                                  color: AppColor.primary_blue[500],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: _showSearchTagSheet,
                      child: TextComponent(
                        title: AppString.search_tag,
                        color: AppColor.primary_blue[500],
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        margin: EdgeInsets.only(top: 16, bottom: 26),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: RawMaterialButton(
                        onPressed: () {
                          widget.resultCallback();
                          Navigator.pop(context);
                        },
                        fillColor: AppColor.primary_blue[500],
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: TextComponent(
                          title: AppString.apply,
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: RawMaterialButton(
                    onPressed: null,
                    fillColor: AppColor.primary_blue[500],
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: TextComponent(
                      title: AppString.apply,
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )*/
          ],
        ),
      ),
    );
  }

  _showSearchTagSheet() {
    return showModalBottomSheet<List<String>>(
      context: context,
      backgroundColor: AppColor.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return AddTagBottomSheetWidget(
          tagList: widget.tagList,
          selectedTagList: (val) {
            setState(() {
              selectedTagList.clear();
              selectedTagList.addAll(val);
            });
          },
        );
      },
    );
  }
}
