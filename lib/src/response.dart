// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

import 'types.dart';
import 'utils.dart';
import 'base_response.dart';

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
      sourceTerminalId: uri.queryParameters['sourceTerminalId'] != null ? int.parse(uri.queryParameters['sourceTerminalId']!) : null,
      merchantID: uri.queryParameters['merchantID'],
    );
  }
}

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
      businessDescriptionType: ParamUtils.stringToBdType(uri.queryParameters['businessDescriptionType']),
      printLogoOnMerchantReceipt: ParamUtils.paramToBool(uri.queryParameters['printLogoOnMerchantReceipt']),
      printVATOnMerchantReceipt: ParamUtils.paramToBool(uri.queryParameters['printVATOnMerchantReceipt']),
      isBarcodeEnabled: ParamUtils.paramToBool(uri.queryParameters['isBarcodeEnabled']),
      businessDescriptionEnabled: ParamUtils.paramToBool(uri.queryParameters['businessDescriptionEnabled']),
      printAddressOnReceipt: ParamUtils.paramToBool(uri.queryParameters['printAddressOnReceipt']),
      isMerchantReceiptEnabled: ParamUtils.paramToBool(uri.queryParameters['isMerchantReceiptEnabled']),
      isCustomerReceiptEnabled: ParamUtils.paramToBool(uri.queryParameters['isCustomerReceiptEnabled']),
    );
  }
}

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

class TransactionResponse extends BaseResponse {
  String? clientTransactionId;
  double amount;
  double tipAmount;
  String? verificationMethod;
  String? rrn;
  String? cartType;
  String? referenceNumber;
  String? accountNumber;
  String? authorisationCode;
  String? tid;
  String? aid;
  String? orderCode;
  String? shortOrderCode;
  DateTime? transactionDate;
  String? transactionId;

  TransactionResponse({
    required status,
    required message,
    required rawData,
    this.clientTransactionId,
    required this.amount,
    required this.tipAmount,
    this.verificationMethod,
    this.rrn,
    this.cartType,
    this.referenceNumber,
    this.accountNumber,
    this.authorisationCode,
    this.tid,
    this.aid,
    this.orderCode,
    this.shortOrderCode,
    this.transactionDate,
    this.transactionId,
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
      cartType: uri.queryParameters['cardType'],
      referenceNumber: uri.queryParameters['referenceNumber'],
      accountNumber: uri.queryParameters['accountNumber'],
      authorisationCode: uri.queryParameters['authorisationCode'],
      tid: uri.queryParameters['tid'],
      aid: uri.queryParameters['aid'],
      orderCode: uri.queryParameters['orderCode'],
      shortOrderCode: uri.queryParameters['shortOrderCode'],
      transactionDate: ParamUtils.paramToDateTime(uri.queryParameters['transactionDate']),
      transactionId: uri.queryParameters['transactionId'],
    );
  }
}

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
