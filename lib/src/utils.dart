// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

import 'dart:math';
import 'types.dart';

class ParamUtils {
  static Uri parseUri(String callback, String value) {
    if (value.isEmpty) {
      return Uri.parse('cb:?status=fail&message=Empty response received from Viva Wallet POS');
    } else if (value.toLowerCase().contains('(-4) user_cancel')) {
      return Uri.parse('cb:?status=userCanceled&message=User canceled');
    } else {
      try {
        return Uri.parse(value.replaceFirst(callback, 'cb:'));
      } on FormatException {
        return Uri.parse('cb:?status=fail&message=Invalid response received from Viva Wallet POS');
      }
    }
  }

  static TransactionStatus statusFromString(String? value) {
    if (value != null) {
      if (value == 'success') {
        return TransactionStatus.success;
      } else if (value == 'userCanceled') {
        return TransactionStatus.userCanceled;
      }
    }
    return TransactionStatus.fail;
  }

  static bool paramToBool(String? value) {
    if (value != null) {
      return value.toLowerCase() == 'true';
    }
    return false;
  }

  static DateTime? paramToDateTime(String? value) {
    if (value == null) return null;
    value = value.replaceAll(' ', '+');
    return DateTime.tryParse(value);
  }

  static int doubleToAmount(double value) {
    num mod = pow(10.0, 2);
    return (((value * mod).round().toDouble() / mod) * 100).toInt();
  }

  static double paramToDouble(String? value) {
    if (value != null) {
      final double? result = double.tryParse(value);
      if (result != null) {
        return result / 100;
      }
    }
    return 0;
  }

  static String bdTypeToString(BusinessDescriptionType? type) {
    switch (type) {
      case BusinessDescriptionType.businessName:
        return 'businessName';
      case BusinessDescriptionType.storeName:
        return 'storeName';
      case BusinessDescriptionType.tradeName:
        return 'tradeName';
      case null:
        return '';
    }
  }

  static BusinessDescriptionType stringToBdType(String? value) {
    switch (value) {
      case 'businessName':
        return BusinessDescriptionType.businessName;
      case 'storeName':
        return BusinessDescriptionType.storeName;
      case 'tradeName':
        return BusinessDescriptionType.tradeName;
    }

    return BusinessDescriptionType.businessName;
  }
}
