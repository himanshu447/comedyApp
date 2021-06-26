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
      return "ca-app-pub-8426276217641603/2909211435";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8426276217641603/2008442749";
    }
    return null;
  }

   static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-8426276217641603/1404558073';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-8426276217641603/7557041068';
    }
    return null;
  }

  ///Test Unit-Id
  /*static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }*/
  ///Test interstitial Unit- Id
 /* static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }*/

  static const String email_pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
}
