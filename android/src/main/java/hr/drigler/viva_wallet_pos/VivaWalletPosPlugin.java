// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

package hr.drigler.viva_wallet_pos;

import android.app.Activity;
import android.net.Uri;
import android.content.Context;
import android.content.Intent;
import android.util.Base64;

//import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class VivaWalletPosPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

  private static final String METHOD_CHANNEL = "viva_wallet_pos/methods";
  private static final String VWP_CLIENT = "vivapayclient://pay/v1";

  private MethodChannel methodChannel;

  private Context context;
  private Activity activity;
  private static Result result;
  private String appId;

  private static String callbackScheme;
  private static String activityResult;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    appId = context.getPackageName();
    callbackScheme = appId + "_cb://result";

    methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), METHOD_CHANNEL);
    methodChannel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    methodChannel.setMethodCallHandler(null);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    VivaWalletPosPlugin.result = result;
    activityResult = "";

    switch (call.method) {
      case "getCallbackScheme":
        result.success(callbackScheme);
        break;
      case "activatePos":
        activatePos(call);
        break;
      case "getActivationCode":
        getActivationCode();
        break;
      case "setModeRequest":
        setModeRequest(call);
        break;
      case "setPrintingSettingsRequest":
        setPrintingSettingsRequest(call);
        break;
      case "setDecimalAmountModeRequest":
        setDecimalAmountModeRequest(call);
        break;
      case "resetTerminalRequest":
        resetTerminalRequest(call);
        break;
      case "reprintTransactionRequest":
        reprintTransactionRequest(call);
        break;
      case "batchRequest":
        batchRequest(call);
        break;
      case "sendLogsRequest":
        sendLogsRequest();
        break;
      case "saleRequest":
        saleRequest(call);
        break;
      case "saleVivaIsvFiscalGreece":
        saleVivaIsvFiscalGreece(call);
        break;
      case "saleRequestGreeceAade":
        saleRequestGreeceAade(call);
        break;
      case "transactionDetailsRequest":
        transactionDetailsRequest(call);
        break;
      case "cancelVivaFiscalGreece":
        cancelVivaFiscalGreece(call);
        break;
      case "cancelRequest":
        cancelRequest(call);
        break;
      case "fastRefundRequest":
        fastRefundRequest(call);
        break;
      case "abortRequest":
        abortRequest(call);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  // Set result from ResponseActivity
  public static void setActivityResult(String data) {
    activityResult = data;
  }

  // Set error from ResponseActivity
  public static void setActivityError(String error) {
    activityResult = callbackScheme + "?status=fail&message=" + error;
  }

  // Send result to Flutter
  public static void sendActivityResult() {
    result.success(activityResult);
  }

  private String addArgumentEncoded(MethodCall call, String argName, boolean useBase64) {
    if (call.hasArgument(argName) && call.argument(argName) != null) {
      String value = call.argument(argName).toString();
      try {
        if (useBase64) {
          value = Base64.encodeToString(value.getBytes("UTF-8"), Base64.NO_WRAP);
        } else {
          value = Uri.encode(value);
        }
      } catch (Exception e) {
        e.printStackTrace();
      }
      return "&" + argName + "=" + value;
    }
    return "";
  }

  private String addArgument(MethodCall call, String argName) {
    if (call.hasArgument(argName) && call.argument(argName) != null) {
      return "&" + argName + "=" + call.argument(argName).toString();
    }
    return "";
  }

  private void activatePos(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=activatePos"
        + "&appId=" + appId
        + addArgument(call, "apikey")
        + addArgument(call, "apiSecret")
        + addArgument(call, "sourceID")
        + addArgument(call, "pinCode")
        + addArgument(call, "skipExternalDeviceSetup")
        + addArgument(call, "activateMoto")
        + addArgument(call, "activateQRCodes")
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void getActivationCode() {
    final String request = VWP_CLIENT
        + "?action=getActivationCode"
        + "&appId=" + appId
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void setModeRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=setMode"
        + "&appId=" + appId
        + addArgument(call, "mode")
        + addArgument(call, "pin")
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void setPrintingSettingsRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=set_printing_settings"
        + "&appId=" + appId
        + addArgument(call, "businessDescriptionEnabled")
        + addArgument(call, "businessDescriptionType")
        + addArgument(call, "printLogoOnMerchantReceipt")
        + addArgument(call, "printVATOnMerchantReceipt")
        + addArgument(call, "isBarcodeEnabled")
        + addArgument(call, "printAddressOnReceipt")
        + addArgument(call, "isMerchantReceiptEnabled")
        + addArgument(call, "isCustomerReceiptEnabled")
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void setDecimalAmountModeRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=amountDecimalMode"
        + "&appId=" + appId
        + addArgument(call, "decimalMode")
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void resetTerminalRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=reset"
        + "&appId=" + appId
        + addArgument(call, "softReset")
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void reprintTransactionRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=print"
        + "&appId=" + appId
        + "&command=reprint"
        + addArgument(call, "orderCode")
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void batchRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=batch"
        + "&appId=" + appId
        + addArgument(call, "command")
        + addArgument(call, "batchId")
        + addArgument(call, "batchName")
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void sendLogsRequest() {
    final String request = VWP_CLIENT
        + "?action=sendLogs"
        + "&appId=" + appId
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void saleVivaIsvFiscalGreece(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=sale"
        + "&appId=" + appId
        + addArgument(call, "clientTransactionId")
        + addArgument(call, "amount")
        + addArgument(call, "tipAmount")
        + addArgument(call, "show_receipt")
        + addArgument(call, "show_transaction_result")
        + addArgument(call, "ISV_amount")
        + addArgument(call, "ISV_clientId")
        + addArgument(call, "ISV_clientSecret")
        + addArgument(call, "ISV_currencyCode")
        + addArgument(call, "ISV_sourceCode")
        + addArgument(call, "ISV_customerTrns")
        + addArgument(call, "ISV_clientTransactionId")
        + addArgumentEncoded(call, "fiscalisationData", true)
        + "&protocol=int_default"
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void saleRequest(MethodCall call) {

    final String request = VWP_CLIENT
        + "?action=sale"
        + "&appId=" + appId
        + addArgument(call, "merchantKey")
        + addArgument(call, "clientTransactionId")
        + addArgument(call, "amount")
        + addArgument(call, "tipAmount")
        + addArgument(call, "show_receipt")
        + addArgument(call, "show_transaction_result")
        + addArgument(call, "show_rating")
        + addArgument(call, "saleToAcquirerData")
        + addArgument(call, "ISV_amount")
        + addArgument(call, "ISV_clientId")
        + addArgument(call, "ISV_clientSecret")
        + addArgument(call, "ISV_merchantId")
        + addArgument(call, "ISV_currencyCode")
        + addArgument(call, "ISV_sourceCode")
        + addArgument(call, "ISV_customerTrns")
        + addArgument(call, "ISV_merchantSourceCode")
        + addArgument(call, "ISV_clientTransactionId")
        + "&protocol=int_default"
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void saleRequestGreeceAade(MethodCall call) {

    final String request = VWP_CLIENT
        + "?action=sale"
        + "&appId=" + appId
        + addArgument(call, "clientTransactionId")
        + addArgument(call, "amount")
        + addArgument(call, "tipAmount")
        + addArgument(call, "show_receipt")
        + addArgument(call, "show_transaction_result")
        + addArgument(call, "ISV_amount")
        + addArgument(call, "ISV_clientId")
        + addArgument(call, "ISV_clientSecret")
        + addArgument(call, "ISV_currencyCode")
        + addArgument(call, "ISV_sourceCode")
        + addArgument(call, "ISV_customerTrns")
        + addArgument(call, "ISV_clientTransactionId")
        + addArgument(call, "aadeProviderId")
        + addArgument(call, "aadeProviderSignatureData")
        + addArgument(call, "aadeProviderSignature")
        + "&protocol=int_default"
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void transactionDetailsRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=transactionDetails"
        + "&appId=" + appId
        + addArgument(call, "merchantKey")
        + addArgument(call, "clientTransactionId")
        + addArgument(call, "sourceTerminalId")
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void cancelVivaFiscalGreece(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=unreferenced_refund"
        + "&appId=" + appId
        + addArgument(call, "amount")
        + addArgument(call, "show_receipt")
        + addArgument(call, "show_transaction_result")
        + addArgumentEncoded(call, "fiscalisationData", true)
        + "&protocol=int_default"
        + "&callback=" + callbackScheme;

    System.out.println(request);
    sendRequest(request);
  }

  private void cancelRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=cancel"
        + "&appId=" + appId
        + addArgument(call, "merchantKey")
        + addArgument(call, "referenceNumber")
        + addArgument(call, "amount")
        + addArgument(call, "orderCode")
        + addArgument(call, "shortOrderCode")
        + addArgument(call, "txnDateFrom")
        + addArgument(call, "txnDateTo")
        + addArgument(call, "show_receipt")
        + addArgument(call, "show_transaction_result")
        + addArgument(call, "show_rating")
        + "&protocol=int_default"
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void fastRefundRequest(MethodCall call) {

    final String request = VWP_CLIENT
        + "?action=send_money_fast_refund"
        + "&appId=" + appId
        + addArgument(call, "referenceNumber")
        + addArgument(call, "amount")
        + addArgument(call, "sourceCode")
        + addArgument(call, "show_receipt")
        + addArgument(call, "show_transaction_result")
        + addArgument(call, "show_rating")
        + "&protocol=int_default"
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void abortRequest(MethodCall call) {
    final String request = VWP_CLIENT
        + "?action=abort"
        + "&appId=" + appId
        + "&callback=" + callbackScheme;

    sendRequest(request);
  }

  private void sendRequest(String request) {
    Intent posIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(request));
    posIntent.addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS);
    // Without this flag it runs under our task and that is what we want
    // posIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    try {
      activity.startActivity(posIntent);
    } catch (Exception e) {
      result.error("Error starting Viva Wallet POS", e.toString(), null);
    }
  }

}
