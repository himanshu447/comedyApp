import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

class MySavedView extends StatefulWidget {
  @override
  _MySavedViewState createState() => _MySavedViewState();
}

class _MySavedViewState extends State<MySavedView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadBody(),
    );
  }

  Widget _loadBody() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            color: AppColor.primary_blue[500],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextComponent(
                title: AppString.laugh_draft,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
                textAlign: TextAlign.center,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: AppBar().preferredSize.height + 20,
                  bottom: 14,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                          filled: false,
                          hintText: AppString.search,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
