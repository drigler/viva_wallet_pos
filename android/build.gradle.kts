plugins {
    id("com.android.library")
}

android {
    namespace = "hr.drigler.viva_wallet_pos"
    compileSdk = 31

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    defaultConfig {
        minSdk = 16
    }
}