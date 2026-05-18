import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'viva_wallet_pos_method_channel.dart';

abstract class VivaWalletPosPlatform extends PlatformInterface {
  /// Constructs a VivaWalletPosPlatform.
  VivaWalletPosPlatform() : super(token: _token);

  static final Object _token = Object();

  static VivaWalletPosPlatform _instance = MethodChannelVivaWalletPos();

  /// The default instance of [VivaWalletPosPlatform] to use.
  ///
  /// Defaults to [MethodChannelVivaWalletPos].
  static VivaWalletPosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VivaWalletPosPlatform] when
  /// they register themselves.
  static set instance(VivaWalletPosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
