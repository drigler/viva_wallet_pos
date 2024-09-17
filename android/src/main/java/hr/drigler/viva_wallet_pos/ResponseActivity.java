// Copyright 2022, Denis Rigler. https://github.com/drigler
// All rights reserved. Use of this source code is governed by a
// MIT-style license that can be found in the LICENSE file.

package hr.drigler.viva_wallet_pos;

import android.app.Activity;
import android.net.Uri;
import android.os.Bundle;

public class ResponseActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(null);
        try {
            final Uri uri = getIntent().getData();
            if (uri == null) {
                throw new Exception("Internal error: Uri is null!");
            }
            final String data = uri.toString();

            VivaWalletPosPlugin.setActivityResult(data);
        } catch (Exception e) {
            VivaWalletPosPlugin.setActivityError(e.toString());
        }
        finish();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        VivaWalletPosPlugin.sendActivityResult();
    }
}