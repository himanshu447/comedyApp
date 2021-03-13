import 'package:comedy/feacture/my_saved/data/model/add_tag_model.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/tag_select_check_list.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

class AddTagBottomSheetWidget extends StatefulWidget {
  final List<AddTagModel> tagList;
  final ValueSetter<List<String>> selectedTagList;

  const AddTagBottomSheetWidget({
    Key key,
    this.tagList,
    this.selectedTagList,
  }) : super(key: key);

  @override
  _AddTagBottomSheetWidgetState createState() =>
      _AddTagBottomSheetWidgetState();
}

class _AddTagBottomSheetWidgetState extends State<AddTagBottomSheetWidget> {
  final List<String> selectedTagList = [];

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
                        visible: selectedTagList.isNotEmpty,
                        child: FlatButton(
                          onPressed: () {
                            widget.selectedTagList(selectedTagList);
                            setState(() {
                              selectedTagList.clear();
                              widget.tagList
                                  .map((e) => e = e.copyWith(isChecked: false));
                              Navigator.pop(context);
                            });
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.tagList.length,
                      itemBuilder: (_, index) {
                        return CheckListTitleComponent(
                          label: widget.tagList[index].label,
                          value: widget.tagList[index],
                          isChecked: widget.tagList[index].isChecked == true,
                          itemSelected: (val) {
                            if (selectedTagList.isNotEmpty) {
                              if (!selectedTagList
                                  .contains(widget.tagList[index])) {
                                selectedTagList
                                    .add(widget.tagList[index].label);
                              }
                            } else {
                              selectedTagList.add(widget.tagList[index].label);
                            }

                            setState(() {
                              widget.tagList[index] = widget.tagList[index]
                                  .copyWith(
                                      isChecked:
                                          !widget.tagList[index].isChecked);
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
