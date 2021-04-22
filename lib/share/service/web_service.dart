import 'dart:convert';
import 'dart:io';

import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<dynamic> requestGET({
    String url,
  }) async {
    Map<String, String> headers;

    headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };

    final response = await http.get(url, headers: headers);

    return _getResponse(response: response);
  }

  Future<dynamic> requestDelete({
    String url,
  }) async {
    Map<String, String> headers;

    headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };

    final response = await http.delete(url, headers: headers);

    return _getResponse(response: response);
  }

  Future<dynamic> requestPOST({
    String url,
    dynamic body,
  }) async {
    Map<String, String> headers;

    headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };

    final response = await http.post(url, headers: headers, body: body);

    return _getResponse(response: response);
  }

  Future<dynamic> requestPUT({
    String url,
    dynamic body,
  }) async {
    Map<String, String> headers;

    headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };

    final response = await http.put(url, headers: headers, body: body);

    return _getResponse(response: response);
  }

  Future<dynamic> requestMultipart({
    String url,
    EventShowModel eventShowModel,
  }) async {
    Map<String, String> headers;

    headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };

    File imageFile = File(eventShowModel.image);

    var stream = new http.ByteStream(imageFile.openRead());

    var length = await imageFile.length();
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: imageFile.path);

    request.files.add(multipartFile);

    request.fields.addAll({
      'name': eventShowModel.name != null ? eventShowModel.name : null,
      'about': eventShowModel.about != null ? eventShowModel.about : null,
      'start_date': eventShowModel.startDate != null
          ? eventShowModel.startDate.toString()
          : null,
      'start_time':
          eventShowModel.startTime != null ? eventShowModel.startTime : null,
      'end_date': eventShowModel.endDate != null
          ? eventShowModel.endDate.toString()
          : null,
      'end_time':
          eventShowModel.endTime != null ? eventShowModel.endTime : null,
      'timezone':
          eventShowModel.timezone != null ? eventShowModel.timezone : null,
      'eventlink':
          eventShowModel.eventLink != null ? eventShowModel.eventLink : null,
      'cost':
          eventShowModel.cost != null ? eventShowModel.cost.toString() : null,
      'timezone': 'GTM +3'
    });

    request.headers.addAll(headers);

    var response = await request.send();

    return await response.stream.toBytes().then((value) {
      return jsonDecode(String.fromCharCodes(value));
    });
  }

  dynamic _getResponse({http.Response response}) {
    try {
      final responseBody = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
        case 201:
          return {
            ConstantUtil.result_success: true,
            ConstantUtil.result_response: responseBody,
          };
        case 400:
          return {
            ConstantUtil.result_success: false,
            ConstantUtil.result_response: responseBody,
          };
        case 401:
          return {
            ConstantUtil.result_success: false,
            ConstantUtil.result_response: ConstantUtil.UNAUTHORIZED,
          };
        case 500:
        case 501:
        case 502:
          return {
            ConstantUtil.result_success: false,
            ConstantUtil.result_response: ConstantUtil.SOMETHING_WRONG,
          };
        default:
          return {
            ConstantUtil.result_success: false,
            ConstantUtil.result_response: ConstantUtil.SOMETHING_WRONG,
          };
      }
    } on SocketException {
      return {
        ConstantUtil.result_success: false,
        ConstantUtil.result_response: ConstantUtil.NO_INTERNET,
      };
    } on FormatException {
      return {
        ConstantUtil.result_success: false,
        ConstantUtil.result_response: ConstantUtil.BAD_RESPONSE,
      };
    } on HttpException {
      return {
        ConstantUtil.result_success: false,
        ConstantUtil.result_response: ConstantUtil.SOMETHING_WRONG,
      };
    }
  }
}


