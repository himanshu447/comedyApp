import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/enum_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class EventShowDataSource {
  Future<dynamic> createEvent();
}

class EventShowDataSourceImpl extends EventShowDataSource {
  final WebService webService;

  EventShowDataSourceImpl({
    @required this.webService,
  });

  @override
  Future createEvent({EventShowModel eventShowModel}) async {
    try {
      var result = await webService.requestPOST(
        url: Services.getServices(
          EndPoint.CreateEvent,
        ),
        body: eventShowModel.toMap(),
      );

      //wait for result

    } catch (e) {
      throw e;
    }
  }
}
