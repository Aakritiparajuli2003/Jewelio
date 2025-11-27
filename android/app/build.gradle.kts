<<<<<<< HEAD
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.1'  // existing
        classpath 'com.google.gms:google-services:4.4.4'  // Firebase plugin
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}



plugins {
    id 'com.android.application'
    id 'kotlin-android'
    id 'dev.flutter.flutter-gradle-plugin'
}

android {
    namespace = "com.jewelio.app"
    compileSdk = flutter.compileSdkVersion

    defaultConfig {
        applicationId = "com.jewelio.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
=======
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.jewelio"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion
>>>>>>> 5b35bb3 (Initial commit)

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

<<<<<<< HEAD
    buildTypes {
        release {
=======
    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.jewelio"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
>>>>>>> 5b35bb3 (Initial commit)
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
<<<<<<< HEAD

apply plugin: 'com.google.gms.google-services'
=======
>>>>>>> 5b35bb3 (Initial commit)
