## 0.1.1 - 2026-01-15
- Added support for Greek fiscalisation. Thanks to [@fotis-psarris](https://github.com/fotis-psarris) for contribution.
- New functions are (saleVivaIsvFiscalGreece, saleRequestGreeceAade, cancelVivaFiscalGreece)
 
## 0.1.0 - 2025-07-10
- Added saleToAcquirerData parameter

## 0.0.9 - 2025-03-13
  - Corrected rounding problem

## 0.0.8 - 2024-09-17
  - Changed the way plugin handles the result from Viva Terminal. Thanks to [@imGok](https://github.com/imGok) for the elegant solution.
  - All plugin users are required to update to this version, because old plugin doesn't work with Viva Terminal 5.19.2  

## 0.0.7 - 2024-09-17
- Added support for more Terminal API calls
  (getActivationCode, reprintTransaction, setDecimalAmountMode, resetTerminal, batch, transactionDetails, fastRefund)

## 0.0.6 - 2024-09-16
- Some tweaks in the code to make plugin more reliable
 
## 0.0.5 - 2024-09-16
- Because of a new way how VivaTerminal works, it is not possible anymore to start it with startActivityForResult
  so now it is using only startActivity and then it waits for a message from VivaTerminal in runable Task.
  It's ugly but it works for now (except it can go in a infinite loop in some conditions, need to resolve that in next version)

## 0.0.4 - 2024-02-17

- Updated dartoc documentation comments

## 0.0.3 - 2024-02-15

- Added ISV sales option thanks to [@jousis9](https://github.com/jousis9)

## 0.0.2 - 2022-08-25

- Update descriptions

## 0.0.1 - 2022-08-18

- Initial beta release
