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
  final BoxFit boxFit;

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
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeftCorner),
        topRight: Radius.circular(topRightCorner),
        bottomRight: Radius.circular(bottomRightCorner),
        bottomLeft: Radius.circular(bottomLeftCorner),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: boxFit,
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
    );
  }
}