// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/services.dart';

import 'response.dart';
import 'types.dart';
import 'utils.dart';

///
/// Flutter plugin for integration with Viva Wallet Pos
///
/// (https://developer.vivawallet.com/apis-for-point-of-sale/)
///
class VivaWalletPos {
  final MethodChannel _methodChannel =
      const MethodChannel('viva_wallet_pos/methods');

  String _callbackScheme = '';

  // Singleton
  VivaWalletPos._();
  static final VivaWalletPos _instance = VivaWalletPos._();
  static VivaWalletPos get instance => _instance;

  // Invoke pos methods
  Future<String> _invokePosMethod(String methodName, Map? methodParams) async {
    if (_callbackScheme.isEmpty) {
      _callbackScheme =
          await _methodChannel.invokeMethod('getCallbackScheme', null);
    }

    final response =
        await _methodChannel.invokeMethod(methodName, methodParams);

    if (response != null) {
      return response;
    }

    return "";
  }

  /// Activate POS method
  ///
  /// (https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/pos_activation/)
  Future<ActivationResponse> activatePos({
    required String apikey,
    required String apiSecret,
    String? sourceID,
    String? pinCode,
    bool skipExternalDeviceSetup = true,
    bool activateMoto = false,
    bool activateQRCodes = false,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'apikey': apikey,
      'apiSecret': apiSecret,
      'sourceID': sourceID,
      'pinCode': pinCode,
      'skipExternalDeviceSetup': skipExternalDeviceSetup,
      'activateMoto': activateMoto,
      'activateQRCodes': activateQRCodes,
    };

    final data = await _invokePosMethod('activatePos', params);

    return ActivationResponse.create(_callbackScheme, data);
  }

  /// Get Activation Code request
  ///
  /// (https://developer.viva.com/apis-for-point-of-sale/card-terminal-apps/android-app/get_activation_code/)
  Future<GetActivationCodeResponse> getActivationCode() async {
    final data = await _invokePosMethod('getActivationCode', null);

    return GetActivationCodeResponse.create(_callbackScheme, data);
  }

  /// Set POS operation mode
  ///
  /// except for ApplicationMode.attended better do not use other modes with this plugin
  ///
  /// (https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/set-mode/)
  Future<SetModeResponse> setMode({
    required ApplicationMode mode,
    required String pin,
  }) async {
    if (int.tryParse(pin) == null) {
      throw Exception('Pin must be numeric!');
    }

    if (pin.length < 4 || pin.length > 6) {
      throw Exception('Pin must be between 4-6 digits length!');
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'mode': mode.index,
      'pin': pin,
    };

    final data = await _invokePosMethod('setModeRequest', params);

    return SetModeResponse.create(_callbackScheme, data);
  }

  /// Send logs to viva devs
  ///
  /// (https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/sendlogs/)
  Future<SendLogsResponse> sendLogs() async {
    final data = await _invokePosMethod('sendLogsRequest', null);

    return SendLogsResponse.create(_callbackScheme, data);
  }

  /// Set printing settings
  ///
  /// (https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/printing/)
  Future<SetPrintingSettingsResponse> setPrintingSettings(
      {bool? businessDescriptionEnabled,
      BusinessDescriptionType? businessDescriptionType,
      bool? printLogoOnMerchantReceipt,
      bool? printVATOnMerchantReceipt,
      bool? isBarcodeEnabled,
      bool? printAddressOnReceipt,
      bool? isMerchantReceiptEnabled,
      bool? isCustomerReceiptEnabled}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'businessDescriptionEnabled': businessDescriptionEnabled,
      'businessDescriptionType':
          ParamUtils.bdTypeToString(businessDescriptionType),
      'printLogoOnMerchantReceipt': printLogoOnMerchantReceipt,
      'printVATOnMerchantReceipt': printVATOnMerchantReceipt,
      'isBarcodeEnabled': isBarcodeEnabled,
      'printAddressOnReceipt': printAddressOnReceipt,
      'isMerchantReceiptEnabled': isMerchantReceiptEnabled,
      'isCustomerReceiptEnabled': isCustomerReceiptEnabled
    };

    final data = await _invokePosMethod('setPrintingSettingsRequest', params);

    return SetPrintingSettingsResponse.create(_callbackScheme, data);
  }

  /// Set decimal amount mode (works only on Card Terminal Apps)
  ///
  /// (https://developer.viva.com/apis-for-point-of-sale/card-terminal-apps/android-app/decimal-amount-mode/)
  Future<SetDecimalAmountModeResponse> setDecimalAmountMode({
    required bool decimalMode,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'decimalMode': decimalMode == true ? '1' : '0',
    };
    final data = await _invokePosMethod('setDecimalAmountModeRequest', params);

    return SetDecimalAmountModeResponse.create(_callbackScheme, data);
  }

  /// Reset Terminal (soft or full reset)
  ///
  /// (https://developer.viva.com/apis-for-point-of-sale/card-terminal-apps/android-app/reset/)
  Future<ResetTerminalResponse> resetTerminal({
    bool softReset = true,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'softReset': softReset,
    };
    final data = await _invokePosMethod('resetTerminalRequest', params);

    return ResetTerminalResponse.create(_callbackScheme, data);
  }

  /// Reprint previously completed transaction
  ///
  /// (https://developer.viva.com/apis-for-point-of-sale/card-terminal-apps/android-app/reprint-transaction/)
  Future<ReprintTransactionResponse> reprintTransaction(
      {required String orderCode}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'orderCode': orderCode,
    };

    final data = await _invokePosMethod('reprintTransactionRequest', params);

    return ReprintTransactionResponse.create(_callbackScheme, data);
  }

  /// Batch Request
  ///
  /// (https://developer.viva.com/apis-for-point-of-sale/card-terminal-apps/android-app/batch/)
  Future<BatchResponse> batch({
    required BatchCommand command,
    String? batchId,
    String? batchName,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'command': command == BatchCommand.open ? 'open' : 'close',
      'batchId': batchId,
      'batchName': batchName,
    };

    final data = await _invokePosMethod('batchRequest', params);

    return BatchResponse.create(_callbackScheme, data);
  }

  /// Transaction Details Request
  ///
  /// (https://developer.viva.com/apis-for-point-of-sale/card-terminal-apps/android-app/transaction-details/)
  Future<TransactionResponse> transactionDetails({
    String? merchantKey,
    required String clientTransactionId,
    required String sourceTerminalId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'merchantKey': merchantKey ?? 'deprecated',
      'clientTransactionId': clientTransactionId,
      'sourceTerminalId': sourceTerminalId,
    };
    final data = await _invokePosMethod('transactionDetailsRequest', params);

    return TransactionResponse.create(_callbackScheme, data);
  }

  /// Make a sale with the ISV schema
  ///
  /// same as sale request but with ISV partner program params
  /// (https://developer.vivawallet.com/isv-partner-program/)
  Future<TransactionResponse> isvSale({
    String? merchantKey,
    required String clientTransactionId,
    required double amount,
    double? tipAmount,
    bool showReceipt = true,
    bool showTransactionResult = true,
    bool showRating = true,
    double? isvAmount,
    required String isvClientId,
    required String isvClientSecret,
    String? isvMerchantId,
    int isvCurrencyCode = 978,
    String isvSourceCode = 'Default',
    String? isvCustomerTrns,
    int? isvMerchantSourceCode,
    String? isvClientTransactionId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'merchantKey': merchantKey ?? 'deprecated',
      'clientTransactionId': clientTransactionId,
      'amount': ParamUtils.doubleToAmount(amount),
      'tipAmount':
          tipAmount != null ? ParamUtils.doubleToAmount(tipAmount) : null,
      'show_receipt': showReceipt,
      'show_transaction_result': showTransactionResult,
      'show_rating': showRating,
      'ISV_amount': ParamUtils.doubleToAmount(isvAmount ?? 0.0),
      'ISV_clientId': isvClientId,
      'ISV_clientSecret': isvClientSecret,
      'ISV_merchantId': isvMerchantId,
      'ISV_currencyCode': isvCurrencyCode,
      'ISV_sourceCode': isvSourceCode,
      'ISV_customerTrns': isvCustomerTrns,
      'ISV_merchantSourceCode': isvMerchantSourceCode,
      'ISV_clientTransactionId': isvClientTransactionId,
    };

    final data = await _invokePosMethod('saleRequest', params);

    return TransactionResponse.create(_callbackScheme, data);
  }

  /// Make a sale
  ///
  /// (https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/sale/)
  Future<TransactionResponse> sale({
    String? merchantKey,
    required String clientTransactionId,
    required double amount,
    double? tipAmount,
    bool showReceipt = true,
    bool showTransactionResult = true,
    bool showRating = true,
    Map<String, dynamic>? saleToAcquirerData,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'merchantKey': merchantKey ?? 'deprecated',
      'clientTransactionId': clientTransactionId,
      'amount': ParamUtils.doubleToAmount(amount),
      'tipAmount':
          tipAmount != null ? ParamUtils.doubleToAmount(tipAmount) : null,
      'show_receipt': showReceipt,
      'show_transaction_result': showTransactionResult,
      'show_rating': showRating,
      'saleToAcquirerData': saleToAcquirerData != null
          ? base64Encode(
              const Utf8Encoder().convert(saleToAcquirerData.toString()))
          : null,
    };

    final data = await _invokePosMethod('saleRequest', params);

    return TransactionResponse.create(_callbackScheme, data);
  }

  /// Cancel transaction -> refund request
  ///
  /// (https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/cancel/)
  Future<TransactionResponse> cancel({
    String? merchantKey,
    String? referenceNumber,
    required double amount,
    String? orderCode,
    String? shortOrderCode,
    DateTime? txnDateFrom,
    DateTime? txnDateTo,
    bool showReceipt = true,
    bool showTransactionResult = true,
    bool showRating = true,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'merchantKey': merchantKey ?? 'deprecated',
      'referenceNumber': referenceNumber,
      'amount': ParamUtils.doubleToAmount(amount),
      'orderCode': orderCode,
      'shortOrderCode': shortOrderCode,
      'txnDateFrom':
          txnDateFrom != null ? '${txnDateFrom.toIso8601String()}Z' : null,
      'txnDateTo': txnDateTo != null ? '${txnDateTo.toIso8601String()}Z' : null,
      'show_receipt': showReceipt,
      'show_transaction_result': showTransactionResult,
      'show_rating': showRating,
    };

    String data = await _invokePosMethod('cancelRequest', params);

    // When using pin if user presses back button and cancels to enter pin
    // POS response is just empty so change it to cancel
    if (data.isEmpty) {
      data = 'cb:?status=userCanceled&message=User canceled';
    }

    return TransactionResponse.create(_callbackScheme, data);
  }

  /// Fast Refund request
  ///
  /// (https://developer.viva.com/apis-for-point-of-sale/card-terminal-apps/android-app/fast_refund/)
  Future<FastRefundResponse> fastRefund({
    String? referenceNumber,
    required double amount,
    String? sourceCode,
    bool showReceipt = true,
    bool showTransactionResult = true,
    bool showRating = true,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'referenceNumber': referenceNumber,
      'amount': ParamUtils.doubleToAmount(amount),
      'sourceCode': sourceCode,
      'show_receipt': showReceipt,
      'show_transaction_result': showTransactionResult,
      'show_rating': showRating,
    };

    String data = await _invokePosMethod('fastRefundRequest', params);

    return FastRefundResponse.create(_callbackScheme, data);
  }

  /// Abort ongoing transaction
  ///
  /// (https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/abort/)
  Future<AbortResponse> abort({String? merchantKey}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'merchantKey': merchantKey ?? 'deprecated',
    };

    final data = await _invokePosMethod('abortRequest', params);

    return AbortResponse.create(_callbackScheme, data);
  }
}
