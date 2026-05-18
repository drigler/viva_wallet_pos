# Viva Wallet POS Flutter

<p align="center">
	<img src="https://raw.githubusercontent.com/drigler/viva_wallet_pos/master/assets/viva_logo.jpg" alt="Viva Logo" />
</p>

<p align="center">
<a href="https://pub.dev/packages/viva_wallet_pos"><img src="https://img.shields.io/pub/v/viva_wallet_pos.svg" alt="Pub"></a>
<a href="https://pub.dev/packages/viva_wallet_pos/score"><img src="https://img.shields.io/pub/likes/viva_wallet_pos?logo=dart" alt="Pub Likes"></a>
<a href="https://pub.dev/packages/viva_wallet_pos/score"><img src="https://img.shields.io/pub/points/viva_wallet_pos?logo=dart" alt="Pub Points"></a>
<a href="https://github.com/drigler/viva_wallet_pos"><img src="https://img.shields.io/github/stars/drigler/viva_wallet_pos.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on GitHub"></a>
<a href="https://github.com/drigler/viva_wallet_pos/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-BSD_3-blue.svg" alt="License: BSD-3-Clause"></a>
</p>

This is a Flutter plugin for Android and iOS integration with Viva Terminal.

You can download the POS app from:

[Google Play Store](https://play.google.com/store/apps/details?id=com.vivawallet.spoc.payapp)

[App Store](https://apps.apple.com/hr/app/viva-com-terminal/id1510538423)

For demo access, you must use the demo version of the Viva.com Terminal App. Contact Viva.com for demo access.

Feel free to contribute to this project on GitHub.

## Installation

Add the package to your project:

```bash
flutter pub add viva_wallet_pos
```

This will add the latest compatible version of `viva_wallet_pos` to your `pubspec.yaml`.

Then run:

```bash
flutter pub get
```

## Getting Started

### Using the library

Please see the example project for basic usage.

Have a look at the official developer page:

https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/

All function and parameter names in the plugin follow the official documentation.

### Sample sale

```dart
import 'package:flutter/foundation.dart';
import 'package:viva_wallet_pos/viva_wallet_pos.dart';

final pos = VivaWalletPos();

try {
  final response = await pos.sale(
    clientTransactionId: 'Invoice 1234',
    amount: 10.00,
    showRating: false,
    showReceipt: true,
    showTransactionResult: false,
  );

  _resultMessage(response.message);
} catch (e) {
  debugPrint(e.toString());
}
```

### Sample ISV sale

```dart
import 'package:flutter/foundation.dart';
import 'package:viva_wallet_pos/viva_wallet_pos.dart';

final pos = VivaWalletPos();

try {
  final response = await pos.isvSale(
    amount: 10.0,
    tipAmount: 0.2,
    isvAmount: 0.1,
    clientTransactionId: 'CLIENT_TRANS_ID',
    isvClientId: 'ISV_CLIENT_ID',
    isvClientSecret: 'ISV_CLIENT_SECRET',
    isvMerchantId: 'ISV_MERCHANT_ID',
    isvClientTransactionId: 'ISV_CLIENT_TRANS_ID',
  );

  _resultMessage(response.message);
} catch (e) {
  debugPrint(e.toString());
}
```

## Supported methods

- [x] activatePos
- [x] getActivationCode
- [x] setMode
- [x] setDecimalAmountMode
- [x] resetTerminal
- [x] batch
- [x] transactionDetails
- [x] fastRefund
- [x] setPrintingSettings
- [x] reprintTransaction
- [x] sendLogs
- [x] sale
- [x] isvSale — new, thanks to @jousis9. See https://github.com/drigler/viva_wallet_pos/pull/1
- [x] saleVivaIsvFiscalGreece — new, thanks to @fotis-psarris. See https://github.com/drigler/viva_wallet_pos/pull/11
- [x] saleRequestGreeceAade — new, thanks to @fotis-psarris. See https://github.com/drigler/viva_wallet_pos/pull/11
- [x] cancelVivaFiscalGreece — new, thanks to @fotis-psarris. See https://github.com/drigler/viva_wallet_pos/pull/11
- [x] cancel
- [x] abort

## Unsupported methods - work in progress

- [ ] preauth request
- [ ] capture pre-auth request
- [ ] rebate request

## Copyright

All trademarks, logos and brand names are the property of their respective owners. Use of these names, trademarks and brands does not imply endorsement.