# Speech_Recognition_App
This is a example of flutter application for recognizing what we speek in the microphone using speech recognition service. 

System Requirements:
IDEA intellij, Visual Studio Code with the Dart/Flutter Plugins, Android Studio or Xcode
The Flutter SDK on the latest Master Build
An Android or iOS Emulator or device for testing

Steps to create and use this app:
Assuming having some basic knowledge of flutter and dart language.(Creating with Andriod Studio and emulator)

1.Create a flutter application 

2.Include the speech_recognition in dependecies section of your pubspec.yaml file.

3.We are going to require the microphone of the phone so in order to do so we need to add permission in both andriod as well as IOS.So in andriod>app>src>main>res>AndroidManifest file. Add <user-permission andriod:name="android.permission.RECORD_AUDIO"/>
and in IOS>Runner>Info.plist file add two keys <key>NSMicrophoneUsageDescription</key> <string>Application needs to access the microphone</string> and <key>NSSpeechRecognitionUsageDescription</key> <string>Application needs the Speech recognition permission</string>.

4.Now import the package of speech recognition in the main.dart. After importing get the dependencies when prompted.

5.Start coding.
