// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

package hr.drigler.viva_wallet_pos;

import android.app.Activity;

//import android.util.Log;
import android.net.Uri;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;


public class VivaWalletPosPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {

  private static final String METHOD_CHANNEL = "viva_wallet_pos/methods";
  private static final String VWP_CLIENT = "vivapayclient://pay/v1";

  private static final int ACTIVITY_RESULT_CODE = 9215;

  private MethodChannel methodChannel;
  private ActivityPluginBinding activityPluginBinding;

  private Context context;
  private Activity activity;
  private Result result;
  private String appId;

  private static String callbackScheme;
  private boolean activityStarted;
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
    this.result = result;
    this.activityResult = "";

    switch (call.method) {
      case "getCallbackScheme":
        this.result.success(callbackScheme);
        break;
      case "activatePos":
        activatePos(call);
        break;
      case "setModeRequest":
        setModeRequest(call);
        break;
      case "setPrintingSettingsRequest":
        setPrintingSettingsRequest(call);
        break;
      case "sendLogsRequest":
        sendLogsRequest();
        break;
      case "saleRequest":
        saleRequest(call);
        break;
      case "cancelRequest":
        cancelRequest(call);
        break;
      case "abortRequest":
        abortRequest(call);
        break;
      default:
        this.result.notImplemented();
        break;
    }
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    binding.addActivityResultListener(this);
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


  private void sendLogsRequest () {
    final String request = VWP_CLIENT
            + "?action=sendLogs"
            + "&appId=" + appId
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
            + "&protocol=int_default"
            + "&callback=" + callbackScheme;

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


  private void abortRequest(MethodCall call) {
    final String request = VWP_CLIENT
            + "?action=abort"
            + "&appId=" + appId
            + "&callback=" + callbackScheme;

    sendRequest(request);
  }


  // Start POS intent with parameters
  // It is not fully as by Viva Wallet devs specs
  // because if started with FLAG_ACTIVITY_NEW_TASK
  // then we cant use onActivityResult
  private void sendRequest(String request) {
    activityStarted = false;
    Intent posIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(request));
    if(posIntent != null) {
      posIntent.addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS);
      try {
        activity.startActivityForResult(posIntent, ACTIVITY_RESULT_CODE);
        activityStarted = true;
      } catch (Exception e) {
        this.result.error("Error starting Viva Wallet POS", e.toString(), null);
      }
    } else {
      this.result.error("Error starting Viva Wallet POS", "Error creating intent", null);
    }
  }

  // Get's triggered once POS intent finishes
  // hopefully POS triggered WalletResponseActivity callback
  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == ACTIVITY_RESULT_CODE) {
      if (activityStarted) {
        this.result.success(activityResult);
        return true;
      }
    }
    return false;
  }

}
