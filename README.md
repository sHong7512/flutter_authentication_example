# flutter_authentication_example

Flutter Authentication. 

1. Portone auth

2. AOS, IOS Device(Pattern, Bio etc.)

3.  AOS, IOS Local Secured PIN

# Build Tip

## Android 

### android/../MainActivity.kt

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity()


### android/app/build.gradle.kts

compileSdk = 36

### android/build.gradle.kts

subprojects {
if (project.name != "app") {
afterEvaluate {
val androidExt = project.extensions.findByName("android")
if (androidExt != null) {
try {
androidExt.javaClass.getMethod("setCompileSdk", Int::class.javaPrimitiveType).invoke(androidExt, 36)
} catch (e: Exception) {
try {
androidExt.javaClass.getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType).invoke(androidExt, 36)
} catch (ignored: Exception) {}
}
}
}
}
}

### android/gradle.properties

android.r8.proguardAndroidTxt.disallowed=false

## IOS

### ios/Podfile

platform :ios, '15.0'

### ios/Runner/Info.plist

/// (<dict>)
	...
	<key>NSFaceIDUsageDescription</key>
        <string>디바이스 OS 인증을 위해 Face ID 권한이 필요합니다.</string>
/// </dict>

## Etc.

포트원 계정 및 키 필요 (KG이니시스 계정인증)

storeId, channelKey, headers ('Portone xxxx')