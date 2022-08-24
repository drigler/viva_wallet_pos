// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

import 'types.dart';

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
