import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Util {
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';

  static String formatDateTime(DateTime? dateTime) {
    return dateTime != null ? DateFormat(dateFormat).format(dateTime) : '';
  }

  // Hàm để định dạng DateTime thành chuỗi giờ
  static String formatTime(DateTime dateTime) {
    return DateFormat(timeFormat).format(dateTime);
  }

  static void showSuccess(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Color(0xFF3EAC77).withOpacity(0.7),
        textColor: Colors.white,
        fontSize: 12.sp);
  }

  static void showFail(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 12.sp);
  }
}
