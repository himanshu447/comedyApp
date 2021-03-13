import 'dart:convert';

import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/data/model/get_all_events_data.dart';
import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/enum_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class EventShowDataSource {
  Future<dynamic> createEvent();

  Future<AllEventsData> allEventDataGet();
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
        body: eventShowModel.tojson(),
      );
      print(result);

      //wait for result

    } catch (e) {
      throw e;
    }
  }

  @override
  Future<AllEventsData> allEventDataGet() async {
    String url = "http://52.66.128.99/comedy_app/api/get-all-event";
    // try {
    //   var result = await webService.requestGET(
    //     url: url,
    //   );
    //   print(result);
    //   return result;
    // } catch (e) {
    //   throw e;
    // }

    Map<String, String> headers;

    headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };
    var response = await http.get(url, headers: headers);

    print(response.body);
    if (response.statusCode == 200) {
      print('Success');
      var res = json.decode(response.body);
      AllEventsData allEventsData = AllEventsData.fromJson(res);
      return allEventsData;
    } else {
      print('Not Success');
      throw Exception();
    }
  }
}
