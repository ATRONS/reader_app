import 'dart:math';

import 'package:flutter/material.dart';

class Helpers {
  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }
}

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Widget addDivider(Color color) {
  return Divider(color: color);
}

String formatIsoDate(String date) {
  final dd = DateTime.parse(date).day;
  final mm = DateTime.parse(date).month;
  final yyyy = DateTime.parse(date).year;

  return dd.toString() + "/" + mm.toString() + "/" + yyyy.toString();
}

bool isValidPhoneNumber(String phoneNum) {
  if (phoneNum.startsWith("+251")) {
    if (phoneNum.length == 13) return true;
  } else if (phoneNum.startsWith("09")) {
    if (phoneNum.length == 10) return true;
  }
  return false;
}
