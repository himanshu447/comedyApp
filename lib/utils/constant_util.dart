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
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }
}
