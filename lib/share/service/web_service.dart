import 'dart:convert';
import 'dart:io';
import 'package:comedy/utils/constant_util.dart';
import 'package:http/http.dart' as http;

class WebService{

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
    File imageFile,
  }) async {
    Map<String, String> headers;

    headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };

    var stream = new http.ByteStream(imageFile.openRead());

    var length = await imageFile.length();
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile =
    new http.MultipartFile('img', stream, length, filename: imageFile.path);
    request.files.add(multipartFile);
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