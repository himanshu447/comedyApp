import 'package:comedy/utils/enum_util.dart';

class Services {
  static final baseUrl = 'http://52.66.128.99/comedy_app/';

  static String getServices(EndPoint endPoint) {
    switch (endPoint) {
      case EndPoint.CreateEvent:
        return baseUrl + 'api/create-event';
      case EndPoint.GetEvents:
        return baseUrl + 'api/get-all-event';
      case EndPoint.CreatePrompt:
        return baseUrl + '/api/create-prompts';
      default:
        return '';
    }
  }
}
