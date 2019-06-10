import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech Recognition App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: VoiceHome(),
    ); //Material App
  } //Build Method
}

class VoiceHome extends StatefulWidget {
  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    //field to get the functionality of speechrecognition
    _speechRecognition = SpeechRecognition();

    //Callback function to see the availability
    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result));
    //callback function to see the microphone is currently listening
    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );
    //callback function to see the text what is spoken in  microphone
    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );
    //Callback function to see recognition stops listening to the microphone
    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );
    //Call to the speech recognition object
    _speechRecognition
        .activate()
        .then((result) => setState(() => _isAvailable = result));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.cancel),
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.cancel().then(
                            (result) => setState(() {
                                  _isListening = result;
                                  resultText = " ";
                                }),
                          );
                  },
                ), //FloatingActionButton
                FloatingActionButton(
                  child: Icon(Icons.mic),
                  backgroundColor: Colors.pink,
                  onPressed: () {
                    if (_isAvailable && !_isListening)
                      _speechRecognition
                          .listen(locale: "en_US")
                          .then((result) => print('$result'));
                  },
                ), //FloatingActionButton

                FloatingActionButton(
                  mini: true,
                  child: Icon(Icons.stop),
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.stop().then(
                          (result) => setState(() => _isListening = result));
                  },
                ), //FloatingActionButton
              ],
            ), //Row
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(6.0),
              ), //BoxDecoration

              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ), //EdgeInsets.symmetric
              child: Text(
                resultText,
                style: TextStyle(fontSize: 24.0),
              ),
            )
          ], //widget
        ),
      ), //Container
    ); //Scaffold
  }
}
