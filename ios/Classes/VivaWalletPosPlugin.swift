import Flutter
import UIKit

public class VivaWalletPosPlugin: NSObject, FlutterPlugin, UIApplicationDelegate {

  private static let methodChannelName = "viva_wallet_pos/methods"
  private static let vwpClientBase = "vivapayclient://pay/v1"

  private static var pendingResult: FlutterResult?

  private static var callbackSchemeOnly: String = ""
  private static var callbackSchemeFull: String = ""

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: methodChannelName,
      binaryMessenger: registrar.messenger()
    )

    let instance = VivaWalletPosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    registrar.addApplicationDelegate(instance)

    let appId = Bundle.main.bundleIdentifier ?? "unknown.bundle"

    callbackSchemeOnly = "\(appId).cb"
    callbackSchemeFull = "\(callbackSchemeOnly)://result"

    print("🔥 iOS VivaWalletPosPlugin registered")
    print("🔥 Bundle id: \(appId)")
    print("🔥 Expected callback scheme only: \(callbackSchemeOnly)")
    print("🔥 Expected callback full: \(callbackSchemeFull)")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("🔥 iOS plugin received method: \(call.method)")

    if VivaWalletPosPlugin.pendingResult != nil {
      result(FlutterError(
        code: "busy",
        message: "Another Viva request is already in progress",
        details: nil
      ))
      return
    }

    switch call.method {
    case "getCallbackScheme":
      result(VivaWalletPosPlugin.callbackSchemeFull)
      return

    case "activatePos",
         "getActivationCode",
         "setModeRequest",
         "setPrintingSettingsRequest",
         "setDecimalAmountModeRequest",
         "resetTerminalRequest",
         "reprintTransactionRequest",
         "batchRequest",
         "sendLogsRequest",
         "saleRequest",
         "saleVivaIsvFiscalGreece",
         "saleRequestGreeceAade",
         "cancelVivaFiscalGreece",
         "transactionDetailsRequest",
         "cancelRequest",
         "fastRefundRequest",
         "abortRequest":
      VivaWalletPosPlugin.pendingResult = result
      let urlString = buildVivaUrl(for: call)
      print("Opening Viva URL:\n\(urlString)")
      openVivaUrl(urlString)
      return

    default:
      result(FlutterMethodNotImplemented)
      return
    }
  }

  // MARK: - Build Viva URL

  private func buildVivaUrl(for call: FlutterMethodCall) -> String {
    let action: String
    switch call.method {
      case "activatePos": action = "activatePos"
      case "getActivationCode": action = "getActivationCode"
      case "setModeRequest": action = "setMode"
      case "setPrintingSettingsRequest": action = "set_printing_settings"
      case "setDecimalAmountModeRequest": action = "amountDecimalMode"
      case "resetTerminalRequest": action = "reset"
      case "reprintTransactionRequest": action = "print"
      case "batchRequest": action = "batch"
      case "sendLogsRequest": action = "sendLogs"
      case "saleRequest": action = "sale"
      case "saleVivaIsvFiscalGreece": action = "sale"
      case "saleRequestGreeceAade": action = "sale"
      case "cancelVivaFiscalGreece": action = "unreferenced_refund"
      case "transactionDetailsRequest": action = "transactionDetails"
      case "cancelRequest": action = "cancel"
      case "fastRefundRequest": action = "send_money_fast_refund"
      case "abortRequest": action = "abort"
      default: action = call.method
    }

    let appId = Bundle.main.bundleIdentifier ?? "unknown.bundle"

    var components = URLComponents()
    components.scheme = "vivapayclient"
    components.host = "pay"
    components.path = "/v1"

    var queryItems: [URLQueryItem] = [
      URLQueryItem(name: "action", value: action),
      URLQueryItem(name: "appId", value: appId),
      URLQueryItem(name: "callback", value: VivaWalletPosPlugin.callbackSchemeOnly),
    ]

    if call.method == "reprintTransactionRequest" {
      queryItems.append(URLQueryItem(name: "command", value: "reprint"))
    }

    if let args = call.arguments as? [String: Any] {
      for (key, value) in args {
        if value is NSNull { continue }

        // keep bools stable (Flutter sometimes sends NSNumber)
        let strValue: String = normalizeToString(value)

        if key == "fiscalisationData" {
          queryItems.append(URLQueryItem(name: key, value: base64UrlSafeWithPadding(strValue)))
        } else {
          queryItems.append(URLQueryItem(name: key, value: strValue))
        }
      }
    }

    let needsProtocol: Set<String> = [
      "saleRequest",
      "saleVivaIsvFiscalGreece",
      "saleRequestGreeceAade",
      "cancelRequest",
      "cancelVivaFiscalGreece",
      "fastRefundRequest",
      "abortRequest"
    ]
    if needsProtocol.contains(call.method) {
      queryItems.append(URLQueryItem(name: "protocol", value: "int_default"))
    }

    let saleMethods: Set<String> = ["saleRequest", "saleVivaIsvFiscalGreece", "saleRequestGreeceAade"]
    if saleMethods.contains(call.method) {
      if let paymentMethod = (call.arguments as? [String: Any])?["paymentMethod"] {
        queryItems.append(URLQueryItem(name: "paymentMethod", value: String(describing: paymentMethod)))
      }
    }
    
    components.queryItems = queryItems
    return components.url?.absoluteString ?? (VivaWalletPosPlugin.vwpClientBase + "?")
  }

  private func normalizeToString(_ value: Any) -> String {
    if let b = value as? Bool { return b ? "true" : "false" }
    if let n = value as? NSNumber, CFGetTypeID(n) == CFBooleanGetTypeID() {
      return n.boolValue ? "true" : "false"
    }
    return String(describing: value)
  }

  private func base64UrlSafeWithPadding(_ s: String) -> String {
    let data = s.data(using: .utf8) ?? Data()
    var b64 = data.base64EncodedString() // keeps '=' padding
    b64 = b64.replacingOccurrences(of: "+", with: "-")
             .replacingOccurrences(of: "/", with: "_")
    return b64
  }

  private func openVivaUrl(_ urlString: String) {
    guard let url = URL(string: urlString) else {
      VivaWalletPosPlugin.pendingResult?(FlutterError(code: "bad_url", message: "Invalid Viva URL", details: urlString))
      VivaWalletPosPlugin.pendingResult = nil
      return
    }

    UIApplication.shared.open(url, options: [:]) { ok in
      if !ok {
        VivaWalletPosPlugin.pendingResult?(FlutterError(
          code: "open_failed",
          message: "Could not open Viva Terminal. Is the Viva app installed?",
          details: urlString
        ))
        VivaWalletPosPlugin.pendingResult = nil
        return
      }

      DispatchQueue.main.asyncAfter(deadline: .now() + 90) {
        if VivaWalletPosPlugin.pendingResult != nil {
          VivaWalletPosPlugin.pendingResult?(FlutterError(
            code: "timeout",
            message: "No callback received from Viva within timeout.",
            details: urlString
          ))
          VivaWalletPosPlugin.pendingResult = nil
        }
      }
    }
  }

  public func application(_ app: UIApplication,
                          open url: URL,
                          options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return VivaWalletPosPlugin.handleCallback(url)
  }

  public static func handleCallback(_ url: URL) -> Bool {
    print("CALLBACK URL received: \(url.absoluteString)")
    print("scheme: \(url.scheme ?? "nil") expected: \(callbackSchemeOnly)")

    guard url.scheme == callbackSchemeOnly else { return false }

    if let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
      print("Path: \(components.path)")
      print("Params: \(components.queryItems ?? [])")
    }

    pendingResult?(url.absoluteString)
    pendingResult = nil
    return true
  }
}