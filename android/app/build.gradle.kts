plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.evently"
    // Updated to 36 because some plugins (fluttertoast, google_sign_in_android,
    // shared_preferences_android) require compiling against SDK 35/36.
    compileSdk = 36
    // ndkVersion removed to avoid build failures when the specified NDK is not installed.
    // If you need a specific NDK, set `ndkVersion = "<installed-version>"` to a version
    // that exists under your Android SDK's `ndk/` directory, or install the required NDK.

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.evently"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
