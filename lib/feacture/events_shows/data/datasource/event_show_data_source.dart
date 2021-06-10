import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/enum_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

abstract class EventShowDataSource {
  Future<EventShowModel> createEvent(EventShowModel eventShowModel);

  Future<List<EventShowModel>> getEvents();
}

class EventShowDataSourceImpl extends EventShowDataSource {
  final WebService webService;

  EventShowDataSourceImpl({
    @required this.webService,
  });

  @override
  Future<EventShowModel> createEvent(EventShowModel eventShowModel) async {
    try {
      var result = await webService.requestMultipart(
        url: Services.getServices(
          EndPoint.CreateEvent,
        ),
        eventShowModel: eventShowModel,
      );

      print(result);

      if (result['status']) {
        return EventShowModel.fromMap(result['data']);
      } else {
        throw result['message'];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Future<List<EventShowModel>> getEvents() async {
    try {
      var localTimeZone = await FlutterNativeTimezone.getLocalTimezone();

      print('result========================>$localTimeZone');


      var result = await webService.requestPUT(
        url: Services.getServices(
          EndPoint.GetEvents,
        ),
        body: {
          'timezone' : localTimeZone,
        }
      );

      print('result========================>$result');

      if (result[ConstantUtil.result_success]) {
        print(result[ConstantUtil.result_success]);

        return (result[ConstantUtil.result_response]['data'] as List)
            .map((e) => EventShowModel.fromMap(e))
            .toList();
      } else {
        throw result[ConstantUtil.result_response];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
