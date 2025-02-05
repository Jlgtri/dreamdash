# Dream Dash

## ![Icon](./source/assets/logo.png?raw=true 'Logo')

### Build

flutter build apk --release --split-per-abi --split-debug-info --obfuscate

### Update Dependencies

flutter pub outdated  --prereleases --dependency-overrides --dev-dependencies

### Create Launch Icons

flutter pub run flutter_launcher_icons:main

### Native Splash

flutter pub run flutter_native_splash:create

flutter pub run flutter_native_splash:remove

### Android: Create Signing Key

keytool -genkey -v -keystore android/app/key.keystore -alias dreamdash -keyalg RSA -keysize 2048 -validity 10000
keytool -importkeystore -srckeystore android/app/key.keystore -destkeystore android/app/key.keystore -deststoretype pkcs12


### Utils

(?:const)?\s*TextStyle\(
\s*color:\s*Colors\.white,
\s*fontSize:\s*16,
\s*fontFamily:\s*'SF Pro Text',
\s*fontWeight:\s*FontWeight\.w600,
\s*height:\s*0\...,
\s*letterSpacing:\s*-0.41,
\s*\)
