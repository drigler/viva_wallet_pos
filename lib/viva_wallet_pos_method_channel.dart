import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'viva_wallet_pos_platform_interface.dart';

/// An implementation of [VivaWalletPosPlatform] that uses method channels.
class MethodChannelVivaWalletPos extends VivaWalletPosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('viva_wallet_pos');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
