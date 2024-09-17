// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

/// Enum for application mode settings
///
/// (https://developer.vivawallet.com/apis-for-point-of-sale/card-terminal-apps/android-app/set-mode/)
enum ApplicationMode { attended, semiUnattended, fullUnattended, ecrControlled }

///
/// Merchant’s Business/Trade/Store name (depending on what option is selected in the 'viva.com | Terminal' application settings)
///
enum BusinessDescriptionType { businessName, tradeName, storeName }

///
/// The status of the transaction
///
enum TransactionStatus { fail, success, userCanceled }

///
/// Batch request action
///
enum BatchCommand { open, close }
