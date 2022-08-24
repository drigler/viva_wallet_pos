# Viva Wallet POS Flutter

This is flutter plugin for Viva Wallet POS App from https://www.vivawallet.com/

You can download POS app from:
https://play.google.com/store/apps/details?id=com.vivawallet.spoc.payapp

For demo acces you must use demo version of Viva Wallet Pos App. Contact VivaWallet for demo access.

This is initial release and currently in testing.

For now, only works on Android.

Feel free to add your contribution to this project on github.

## Installation
Use this package as a library
1. Depend on it
Add this to your package's pubspec.yaml file:

```` dart
dependencies:
  viva_wallet_pos: ^0.0.1
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

Sample:
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

## Supported methods
- [x]  activatePos
- [x]  setMode
- [x]  setPrintingSettings
- [x]  sendLogs
- [x]  sale
- [x]  cancel
- [x]  abort
