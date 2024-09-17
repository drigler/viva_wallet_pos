// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

import 'base_response.dart';
import 'types.dart';
import 'utils.dart';

/// Response from [activatePos] request
class ActivationResponse extends BaseResponse {
  ActivationResponse({
    required status,
    required message,
    required rawData,
    String? virtualId,
    int? sourceTerminalId,
    String? merchantID,
  }) : super(status: status, message: message, rawData: rawData);

  factory ActivationResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return ActivationResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
      virtualId: uri.queryParameters['virtualId'],
      sourceTerminalId: uri.queryParameters['sourceTerminalId'] != null
          ? int.parse(uri.queryParameters['sourceTerminalId']!)
          : null,
      merchantID: uri.queryParameters['merchantID'],
    );
  }
}

/// Response from [getActivationCode] request
class GetActivationCodeResponse extends BaseResponse {
  GetActivationCodeResponse({
    required status,
    required message,
    required rawData,
    String? virtualId,
    String? activationCode,
    String? merchantID,
  }) : super(status: status, message: message, rawData: rawData);

  factory GetActivationCodeResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return GetActivationCodeResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
      virtualId: uri.queryParameters['virtualId'],
      activationCode: uri.queryParameters['activationCode'],
      merchantID: uri.queryParameters['merchantID'],
    );
  }
}

/// Response from [setMode] request
class SetModeResponse extends BaseResponse {
  SetModeResponse({
    required status,
    required message,
    required rawData,
  }) : super(status: status, message: message, rawData: rawData);

  factory SetModeResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return SetModeResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
    );
  }
}

/// Response from [setPrintingSettings] request
class SetPrintingSettingsResponse extends BaseResponse {
  final BusinessDescriptionType businessDescriptionType;
  final bool printLogoOnMerchantReceipt;
  final bool printVATOnMerchantReceipt;
  final bool isBarcodeEnabled;
  final bool businessDescriptionEnabled;
  final bool printAddressOnReceipt;
  final bool isMerchantReceiptEnabled;
  final bool isCustomerReceiptEnabled;

  SetPrintingSettingsResponse({
    required status,
    required message,
    required rawData,
    required this.businessDescriptionType,
    required this.printLogoOnMerchantReceipt,
    required this.printVATOnMerchantReceipt,
    required this.isBarcodeEnabled,
    required this.businessDescriptionEnabled,
    required this.printAddressOnReceipt,
    required this.isMerchantReceiptEnabled,
    required this.isCustomerReceiptEnabled,
  }) : super(status: status, message: message, rawData: rawData);

  factory SetPrintingSettingsResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return SetPrintingSettingsResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
      businessDescriptionType: ParamUtils.stringToBdType(
          uri.queryParameters['businessDescriptionType']),
      printLogoOnMerchantReceipt: ParamUtils.paramToBool(
          uri.queryParameters['printLogoOnMerchantReceipt']),
      printVATOnMerchantReceipt: ParamUtils.paramToBool(
          uri.queryParameters['printVATOnMerchantReceipt']),
      isBarcodeEnabled:
          ParamUtils.paramToBool(uri.queryParameters['isBarcodeEnabled']),
      businessDescriptionEnabled: ParamUtils.paramToBool(
          uri.queryParameters['businessDescriptionEnabled']),
      printAddressOnReceipt:
          ParamUtils.paramToBool(uri.queryParameters['printAddressOnReceipt']),
      isMerchantReceiptEnabled: ParamUtils.paramToBool(
          uri.queryParameters['isMerchantReceiptEnabled']),
      isCustomerReceiptEnabled: ParamUtils.paramToBool(
          uri.queryParameters['isCustomerReceiptEnabled']),
    );
  }
}

/// Response from [setDecimalAmountModeRequest] request
class SetDecimalAmountModeResponse extends BaseResponse {
  SetDecimalAmountModeResponse({
    required status,
    required message,
    required rawData,
  }) : super(status: status, message: message, rawData: rawData);

  factory SetDecimalAmountModeResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return SetDecimalAmountModeResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
    );
  }
}

/// Response from [resetTerminalRequest] request
class ResetTerminalResponse extends BaseResponse {
  ResetTerminalResponse({
    required status,
    required message,
    required rawData,
  }) : super(status: status, message: message, rawData: rawData);

  factory ResetTerminalResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return ResetTerminalResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
    );
  }
}

/// Response from [reprintTransaction] request
class ReprintTransactionResponse extends BaseResponse {
  ReprintTransactionResponse({
    required status,
    required message,
    required rawData,
  }) : super(status: status, message: message, rawData: rawData);

  factory ReprintTransactionResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return ReprintTransactionResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
    );
  }
}

/// Response from [batchRequest] request
class BatchResponse extends BaseResponse {
  final String batchId;
  final String batchName;

  BatchResponse({
    required status,
    required message,
    required rawData,
    required this.batchId,
    required this.batchName,
  }) : super(status: status, message: message, rawData: rawData);

  factory BatchResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return BatchResponse(
        status: ParamUtils.statusFromString(uri.queryParameters['status']),
        message: uri.queryParameters['message'] ?? '',
        rawData: data,
        batchId: uri.queryParameters['batchId'] ?? '',
        batchName: uri.queryParameters['batchName'] ?? '');
  }
}

/// Response from [sendLogs] request
class SendLogsResponse extends BaseResponse {
  SendLogsResponse({
    required status,
    required message,
    required rawData,
  }) : super(status: status, message: message, rawData: rawData);

  factory SendLogsResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return SendLogsResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
    );
  }
}

/// Sale transaction response  from [sale], [isvSale], [transactionDetails] and [cancel] requests
class TransactionResponse extends BaseResponse {
  String? clientTransactionId;
  double amount;
  double tipAmount;
  String? verificationMethod;
  String? rrn;
  String? cardType;
  String? referenceNumber;
  String? accountNumber;
  String? authorisationCode;
  String? tid;
  String? aid;
  String? orderCode;
  String? shortOrderCode;
  DateTime? transactionDate;
  String? transactionId;

  double? isvAmount;
  String? isvClientId;
  String? isvClientSecret;
  String? isvMerchantId;
  int? currency;
  TransactionResponse({
    required status,
    required message,
    required rawData,
    this.clientTransactionId,
    required this.amount,
    required this.tipAmount,
    this.verificationMethod,
    this.rrn,
    this.cardType,
    this.referenceNumber,
    this.accountNumber,
    this.authorisationCode,
    this.tid,
    this.aid,
    this.orderCode,
    this.shortOrderCode,
    this.transactionDate,
    this.transactionId,
    this.isvAmount,
    this.isvClientId,
    this.isvClientSecret,
    this.isvMerchantId,
    this.currency,
  }) : super(status: status, message: message, rawData: rawData);

  factory TransactionResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return TransactionResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
      clientTransactionId: uri.queryParameters['clientTransactionId'],
      amount: ParamUtils.paramToDouble(uri.queryParameters['amount']),
      tipAmount: ParamUtils.paramToDouble(uri.queryParameters['tipAmount']),
      verificationMethod: uri.queryParameters['verificationMethod'],
      rrn: uri.queryParameters['rrn'],
      cardType: uri.queryParameters['cardType'],
      referenceNumber: uri.queryParameters['referenceNumber'],
      accountNumber: uri.queryParameters['accountNumber'],
      authorisationCode: uri.queryParameters['authorisationCode'],
      tid: uri.queryParameters['tid'],
      aid: uri.queryParameters['aid'],
      orderCode: uri.queryParameters['orderCode'],
      shortOrderCode: uri.queryParameters['shortOrderCode'],
      transactionDate:
          ParamUtils.paramToDateTime(uri.queryParameters['transactionDate']),
      transactionId: uri.queryParameters['transactionId'],
      isvAmount: ParamUtils.paramToDouble(uri.queryParameters['ISV_amount']),
      isvClientId: uri.queryParameters['ISV_clientId'],
      isvClientSecret: uri.queryParameters['ISV_clientSecret'],
      isvMerchantId: uri.queryParameters['ISV_merchantId'],
      currency: int.tryParse(uri.queryParameters['currency'] ?? ''),
    );
  }
}

/// Fast Refund response  from [fastRefund] request
class FastRefundResponse extends BaseResponse {
  double amount;
  String? sourceCode;
  String? cardType;
  String? accountNumber;
  String? tid;
  String? transactionId;
  String? aadeTransactionId;

  FastRefundResponse({
    required status,
    required message,
    required rawData,
    required this.amount,
    this.sourceCode,
    this.cardType,
    this.accountNumber,
    this.tid,
    this.transactionId,
    this.aadeTransactionId,
  }) : super(status: status, message: message, rawData: rawData);

  factory FastRefundResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return FastRefundResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
      amount: ParamUtils.paramToDouble(uri.queryParameters['amount']),
      sourceCode: uri.queryParameters['sourceCode'],
      cardType: uri.queryParameters['cardType'],
      accountNumber: uri.queryParameters['accountNumber'],
      tid: uri.queryParameters['tid'],
      transactionId: uri.queryParameters['transactionId'],
      aadeTransactionId: uri.queryParameters['aadeTransactionId'],
    );
  }
}

/// Response from [abort] request
class AbortResponse extends BaseResponse {
  AbortResponse({
    required status,
    required message,
    required rawData,
  }) : super(status: status, message: message, rawData: rawData);

  factory AbortResponse.create(String cb, String data) {
    Uri uri = ParamUtils.parseUri(cb, data);

    return AbortResponse(
      status: ParamUtils.statusFromString(uri.queryParameters['status']),
      message: uri.queryParameters['message'] ?? '',
      rawData: data,
    );
  }
}
