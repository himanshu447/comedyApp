import 'dart:io';

import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/enum_util.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

abstract class SavePromptDataSource {
  Future<int> savePrompt(int promptId);
}

class SavePromptDataSourceImpl extends SavePromptDataSource {

  final WebService webService;
  final DeviceInfoPlugin deviceInfoPlugin;

  SavePromptDataSourceImpl({this.webService, this.deviceInfoPlugin,});


  @override
  Future<int> savePrompt(int promptId) async {

    var deviceId = await _getDeviceId();

    try {
      var result = await webService.requestPOST(
          url: Services.getServices(
            EndPoint.SavedPrompt,
          ),
          body: {
            'device_token' : deviceId,
            'prompt_id' : promptId,
          }
      );
      print(result);

      if (result[ConstantUtil.result_success]) {
        return result[ConstantUtil.result_response]['data']['id'];
      } else {
        print(result[ConstantUtil.result_response]);
        throw result[ConstantUtil.result_response];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }


  Future<String> _getDeviceId()async{
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return  build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor;  //UUID for iOS
      }else{
        return null;
      }
    } on PlatformException catch(e){
      throw e.message;
    }
  }
}