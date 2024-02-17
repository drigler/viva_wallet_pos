// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

import 'types.dart';

/// Base response class for all requests
///
/// Every request result have
/// TransactionStatus - the status of transaction  (success, fail or user canceled)
/// Message - for example Transaction successful, declined etc...
/// rawData - raw transaction response data
abstract class BaseResponse {
  TransactionStatus status = TransactionStatus.fail;
  String message;
  String? rawData;

  BaseResponse({
    required this.status,
    required this.message,
    required this.rawData,
  });
}
