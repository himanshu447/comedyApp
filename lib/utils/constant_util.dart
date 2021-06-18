import 'dart:io';

class ConstantUtil {
  static const String UNAUTHORIZED = 'Unauthorized Request';
  static const String NO_INTERNET = 'No Internet Available';
  static const String BAD_RESPONSE = 'Bad Response';
  static const String SERVER_ERROR = 'Server Error';
  static const String SOMETHING_WRONG = 'Server Error';

  static const String result_success = 'success'; 
  static const String result_response = 'response';

  static const int START_TIMER_VALUE = 300;
  static const int END_TIMER_VALUE = 0;

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return "ca-app-pub-8426276217641603/2914809231";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8426276217641603/2723237547";
    }
    return null;
  }

  static const String email_pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
}
