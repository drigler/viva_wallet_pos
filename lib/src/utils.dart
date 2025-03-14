// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

//import 'dart:math';
import 'types.dart';

///
/// Utility functions
///
class ParamUtils {
  /// Make uniform Uri with status and message
  static Uri parseUri(String callback, String value) {
    if (value.isEmpty) {
      return Uri.parse(
          'cb:?status=fail&message=Empty response received from Viva Wallet POS');
    } else if (value.toLowerCase().contains('(-4) user_cancel')) {
      return Uri.parse('cb:?status=userCanceled&message=User canceled');
    } else {
      try {
        return Uri.parse(value.replaceFirst(callback, 'cb:'));
      } on FormatException {
        return Uri.parse(
            'cb:?status=fail&message=Invalid response received from Viva Wallet POS');
      }
    }
  }

  /// Convert string status to TransactionStatus enum
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

  /// Convert string value to bool
  static bool paramToBool(String? value) {
    if (value != null) {
      return value.toLowerCase() == 'true';
    }
    return false;
  }

  /// Convert string value to DateTime
  static DateTime? paramToDateTime(String? value) {
    if (value == null) return null;
    value = value.replaceAll(' ', '+');
    return DateTime.tryParse(value);
  }

  /// Convert double value to int value
  ///
  /// Amounts are represented as integers, last two digits of int are decimals
  static int doubleToAmount(double value) {
    //num mod = pow(10.0, 2);
    //return (((value * mod).round().toDouble() / mod) * 100).toInt();
    return (value*100).round();
  }

  /// Convert amount from string to double value
  static double paramToDouble(String? value) {
    if (value != null) {
      final double? result = double.tryParse(value);
      if (result != null) {
        return result / 100;
      }
    }
    return 0;
  }

  ///  Convert business type to string representation
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

  /// Convert string value to business type representation
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
