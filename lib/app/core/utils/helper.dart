import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Helper {

  static String stringSplit(String data){
    int idx = data.indexOf(" ");
    List parts = [data.substring(0,idx).trim(), data.substring(idx+1).trim()];

    return parts[0];
  }

  static String dateFormat(DateTime date) {
    return DateFormat('dd MMM yyyy', Get.locale.toString()).format(date);
  }
  static String dateTimeFormat(DateTime date) {
    return '${DateFormat('MMM dd At hh:mm', Get.locale.toString()).format(date)} ${getENTimeBD(date)}';
  }
  static String timeFormat(DateTime date) {
    return '${DateFormat('hh:mm:ss', Get.locale.toString()).format(date)} ${getENTimeBD(date)}';
  }
  static String dateFormatST(String date) {
    return DateFormat('MMM dd yyyy', Get.locale.toString()).format(DateTime.parse(date));
  }

  static String getENTimeBD(DateTime dateTime) {
    if (dateTime.hour < 12) {
      return Get.locale.toString() == "en" ? "AM" : "পূর্বাহ্ণ";
    } else {
      return Get.locale.toString() == "en" ? "PM" :"অপরাহ্ণ";
    }
  }
  static String truncateString(String data, int length) {
    return (data.length >= length) ? '${data.substring(0, length)}...' : data;
  }
  static bool dateTimeCompare(DateTime targetDateTime) {
    DateTime currentDateTime = DateTime.now();
    return targetDateTime.isAfter(currentDateTime);
  }

  static bool phoneNumberCheck(String data) {
    if(data.length == 11){
      var operatorList = ['013', '017', '014', '019', '015', '016', '018'];
      return operatorList.any((element) => data.startsWith(element));
    }
    return false;
  }

  static String engNumberToBengali(String number) {
    Map numbers = {
      '0' : '০', '1' : '১', '2' : '২',
      '3' : '৩', '4' : '৪', '5' : '৫',
      '6' : '৬', '7' : '৭', '8' : '৮',
      '9' : '৯',
    };
    numbers.forEach((key, value) => number = number.replaceAll(key, value));
    return number;
  }

}
