import 'dart:async';
import 'dart:io';
import 'package:contactus/contactus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vision/help.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String newVoiceText = 'Empty';
FlutterTts flutterTts = FlutterTts();
Future speak() async {
  print(newVoiceText);
  await flutterTts.setVolume(1.0);
  await flutterTts.setSpeechRate(0.9);
  await flutterTts.setLanguage('hi-IN');
  await flutterTts.setPitch(0.8);
  await flutterTts.setVoice('en-gb-x-rjs#female_3-local');
  if (newVoiceText != null) {
    if (newVoiceText.isNotEmpty) {
      await flutterTts.speak(newVoiceText);
    }
  }
}

class Vision extends StatefulWidget {
  @override
  _VisionState createState() => _VisionState();
}

class _VisionState extends State<Vision> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  List<OcrText> _textsOcr = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text('Vision'),
        leading: Icon(
          FontAwesomeIcons.eye,
          color: Colors.greenAccent,
          size: 25.0,
        ),
        elevation: 60.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              color: Colors.greenAccent,
              iconSize: 25.0,
              icon: Icon(FontAwesomeIcons.question),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Help();
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              color: Colors.red.shade400,
              iconSize: 25.0,
              icon: FaIcon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                exit(1);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Abhishek Doshi',
        backgroundColor: Colors.transparent,
        textColor: Colors.black38,
        email: 'adoshi26.ad@gmail.com',
      ),
      body: _getOcrScreen(context),
    );
  }

  Widget _getOcrScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 60.0,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset('assets/desktop.jpg'),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 70.0,
            height: 70.0,
            color: Colors.transparent,
            child: Card(
              elevation: 20,
              color: Colors.blue.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              child: IconButton(
                splashColor: Colors.transparent,
                icon: FaIcon(
                  FontAwesomeIcons.teamspeak,
                  color: Colors.greenAccent,
                  size: 30.0,
                ),
                onPressed: () {
                  _read();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        autoFocus: true,
        multiple: true,
        waitTap: true,
        camera: _cameraOcr,
        fps: 10.0,
      );
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }

    if (!mounted) return;

    setState(() {
      _textsOcr = texts;
      newVoiceText = '';
      texts.forEach((f) {
        newVoiceText += f.value;
      });
      speak();
    });
  }
}
