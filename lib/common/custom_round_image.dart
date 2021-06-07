import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomRoundCornerImage extends StatelessWidget {
  final double height;
  final double width;
  final String image;
  final File fileImage;
  final String placeholder;

  double topRightCorner = 0.0,
      topLeftCorner = 0.0,
      bottomLeftCorner = 0.0,
      bottomRightCorner = 0.0;

  CustomRoundCornerImage({
    this.height,
    this.width,
    this.image,
    this.fileImage,
    this.placeholder,
    this.topRightCorner,
    this.topLeftCorner,
    this.bottomLeftCorner,
    this.bottomRightCorner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftCorner),
          topRight: Radius.circular(topRightCorner),
          bottomRight: Radius.circular(bottomRightCorner),
          bottomLeft: Radius.circular(bottomLeftCorner),
        ),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.none,
          placeholder: (context, url) => Container(
            child: Center(
              child: new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    AppColor.primary_blue[500]),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: new CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColor.primary_blue[500]),
            ),
          ),
        ),
      ),
    );
  }
}
/*
Container(
            height: width,
            width: height,
            decoration: BoxDecoration(
              /*  color: Color(0xFFdbdbdb),*/
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeftCorner),
                topRight: Radius.circular(topRightCorner),
                bottomRight: Radius.circular(bottomRightCorner),
                bottomLeft: Radius.circular(bottomLeftCorner),
              ),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: fileImage == null
                      ? AssetImage(('assets/$placeholder'))
                      : FileImage(fileImage)),
              /* new Image.asset('assets/test.jpg')*/
            ),
          ),
        ),
      ),
    )
 */
