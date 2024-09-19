# Viva Wallet POS Flutter
</p>
<p align="center">
![](https://private-user-images.githubusercontent.com/34372972/368933043-abb28e3e-a8e6-4006-9e2b-d4b37ee155e4.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MjY3NDA5MDMsIm5iZiI6MTcyNjc0MDYwMywicGF0aCI6Ii8zNDM3Mjk3Mi8zNjg5MzMwNDMtYWJiMjhlM2UtYThlNi00MDA2LTllMmItZDRiMzdlZTE1NWU0LmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA5MTklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwOTE5VDEwMTAwM1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWY0YjRlNDM2ZjcyYmQzN2JmOWI4OTE0YjZmMzA4ZWQxYjY0NWRkYmJiNDYwNDFhNTQ4NjViYmE1MTU5NjFjYTYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.JjM4XXnLoxWMo0CFtEzwCp9VFau27qv3hOW_MNuCPho)
</p>
<p align="center">
<a href="https://pub.dev/packages/viva_wallet_pos"><img src="https://img.shields.io/pub/v/viva_wallet_pos.svg" alt="Pub"></a>
<a href="https://pub.dev/packages/viva_wallet_pos/score"><img src="https://img.shields.io/pub/likes/viva_wallet_pos?logo=dart" alt="Pub"></a>
<a href="https://pub.dev/packages/viva_wallet_pos/score"><img src="https://img.shields.io/pub/popularity/viva_wallet_pos?logo=dart" alt="Pub"></a>
<a href="https://pub.dev/packages/viva_wallet_pos/score"><img src="https://img.shields.io/pub/points/viva_wallet_pos?logo=dart" alt="Pub"></a>
<a href="https://github.com/drigler/viva_wallet_pos"><img src="https://img.shields.io/github/stars/drigler/viva_wallet_pos.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
<a href="https://github.com/drigler/viva_wallet_pos/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-BSD_3-blue.svg" alt="License: MIT"></a>
</p>
This is a flutter plugin for Android integration with Viva Wallet POS.

You can download POS app from [Google Play Store ](https://play.google.com/store/apps/details?id=com.vivawallet.spoc.payapp)

For demo acces you must use demo version of Viva Wallet Pos App. Contact VivaWallet for demo access. For now, only works on Android.

Feel free to add your contribution to this project on github.

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
- [x]  getActivationCode
- [x]  setMode
- [x]  setDecimalAmountMode
- [x]  resetTerminal
- [x]  batch
- [x]  transactionDetails
- [x]  fastRefund
- [x]  setPrintingSettings
- [x]  reprintTransaction
- [x]  sendLogs
- [x]  sale
- [x]  isvSale (new thanks to jousis9 see https://github.com/drigler/viva_wallet_pos/pull/1)
- [x]  cancel
- [x]  abort

## Unsupported methods - work in progress
- [ ]  preauth request
- [ ]  capture pre-auth request
- [ ]  rebate request