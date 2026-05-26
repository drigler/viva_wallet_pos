import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viva_wallet_pos/viva_wallet_pos_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelVivaWalletPos platform = MethodChannelVivaWalletPos();
  const MethodChannel channel = MethodChannel('viva_wallet_pos');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
