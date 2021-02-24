

import 'package:comedy/utils/enum_util.dart';

class Services {
  static final baseUrl = '';

  static String getServices(EndPoint endPoint) {
    switch (endPoint) {
      case EndPoint.Login:
        return baseUrl + 'login';
      case EndPoint.UserList:
        return baseUrl + 'users?page=1';
      case EndPoint.CreateUser:
        return baseUrl + 'users';

      default:
        return '';
    }
  }
}