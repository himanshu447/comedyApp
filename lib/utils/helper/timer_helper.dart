import 'package:intl/intl.dart';

class TimerHelper {
  static String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  static String utcToLocal({DateTime utcDate, DateFormat dateFormat}){
    var utDate = dateFormat.format(utcDate);
    var startLocalDate = dateFormat.parse(utDate, true).toLocal().toString();
    return dateFormat.format(DateTime.parse(startLocalDate));
  }
}
