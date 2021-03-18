import 'dart:io';

import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/enum_util.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

abstract class MySavedDataSource {
  Future<List<MySavedModel>> getMySavedPrompt();
}

class MySavedDataSourceImpl extends MySavedDataSource {
  final WebService webService;
  final DeviceInfoPlugin deviceInfoPlugin;

  MySavedDataSourceImpl({
    this.webService,
    this.deviceInfoPlugin,
  });

  @override
  Future<List<MySavedModel>> getMySavedPrompt() async {
    var deviceId = await _getDeviceId();

    try {
      var result = await webService.requestPOST(
        url: Services.getServices(
          EndPoint.GetSavedPrompt,
        ),
        body: {
          'device_token': deviceId,
        },
      );
      print(result);

      if (result[ConstantUtil.result_success]) {
        return (result[ConstantUtil.result_response]['data'] as List)
            .map((e) => MySavedModel.fromMap(e))
            .toList();
      } else {
        print(result[ConstantUtil.result_response]);
        throw result[ConstantUtil.result_response];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<String> _getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor; //UUID for iOS
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      throw e.message;
    }
  }
}
