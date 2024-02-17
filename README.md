# Viva Wallet POS Flutter

This is a flutter plugin for Android integration with Viva Wallet POS.

You can download POS app from:
https://play.google.com/store/apps/details?id=com.vivawallet.spoc.payapp

For demo acces you must use demo version of Viva Wallet Pos App. Contact VivaWallet for demo access.

For now, only works on Android.

Feel free to add your contribution to this project on github.

## Installation
Use this package as a library
1. Depend on it
Add this to your package's pubspec.yaml file:

```` dart
dependencies:
  viva_wallet_pos: ^0.0.4
````

2. Install it
You can install packages from the command line:


with Flutter:
````
$ flutter packages get
````

## Getting Started

#### Using the library

Please se example project on how to use library basic functions.

Have a look at official developer page: https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/

All the functions and parameter names in the plugin are same as in the official documentation.  

Sample sale:
```dart
import 'package:viva_wallet_pos/viva_wallet_pos.dart';

VivaWalletPos pos = VivaWalletpos();

try {
      TransactionResponse response = await pos.sale(
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

Sample ISV sale:
```dart
import 'package:viva_wallet_pos/viva_wallet_pos.dart';

VivaWalletPos pos = VivaWalletpos();

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
- [x]  activatePos
- [x]  setMode
- [x]  setPrintingSettings
- [x]  sendLogs
- [x]  sale
- [x]  isvSale (new thanks to jousis9 see https://github.com/drigler/viva_wallet_pos/pull/1)
- [x]  cancel
- [x]  abort
