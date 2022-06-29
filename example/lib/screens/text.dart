import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../constants.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;

class VoiceDrive extends StatefulWidget {
  late BluetoothDevice server;
  VoiceDrive({Key? key, required this.server}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Content();
  }
}

class Content extends State<VoiceDrive> {
  late speechToText.SpeechToText speech;
  String textString = "Presser le Button";
  bool isListen = false;
  double confidence = 1.0;

  BluetoothConnection? connection;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(null).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  final Map<String, HighlightedWord> highlightWords = {
    "flutter": HighlightedWord(
        textStyle:
            TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
    "developer": HighlightedWord(
        textStyle:
            TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
  };

  void listen() async {
    if (!isListen) {
      bool avail = await speech.initialize();
      if (avail) {
        setState(() {
          isListen = true;
        });
        speech.listen(onResult: (value) {
          setState(() {
            textString = value.recognizedWords;
            sendCommande(textString);
            if (value.hasConfidenceRating && value.confidence > 0) {
              confidence = value.confidence;
            }
          });
        });
      }
    } else {
      setState(() {
        isListen = false;
      });
      speech.stop();
    }
  }

  Future<void> sendCommande(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        if (text.contains("left")) {
          text = 'L';
          connection!.output
              .add(Uint8List.fromList(utf8.encode(text + "\r\n")));
          await connection!.output.allSent;
          print("le code envoiyer est :  " + text);
        } else if (text.contains("right")) {
          text = 'R';
          connection!.output
              .add(Uint8List.fromList(utf8.encode(text + "\r\n")));
          await connection!.output.allSent;
          print("le code envoiyer est :  " + text);
        } else if (text.contains("forward")) {
          text = 'F';
          connection!.output
              .add(Uint8List.fromList(utf8.encode(text + "\r\n")));
          await connection!.output.allSent;
          print("le code envoiyer est :  " + text);
        } else if (text.contains("backward")) {
          text = 'B';
          connection!.output
              .add(Uint8List.fromList(utf8.encode(text + "\r\n")));
          await connection!.output.allSent;
          print("le code envoiyer est :  " + text);
        } else if (text.contains("stop")) {
          text = 'S';
          connection!.output
              .add(Uint8List.fromList(utf8.encode(text + "\r\n")));
          await connection!.output.allSent;
          print("le code envoiyer est :  " + text);
        }

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            'Voice Drive' +
                (isConnected ? ' (connecter)' : ' (attend la connection ...)'),
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: secondaryColor,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                "Confidence: ${(confidence * 100.0).toStringAsFixed(1)}%",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextHighlight(
                text: textString,
                words: highlightWords,
                textStyle: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        floatingActionButton: AvatarGlow(
          animate: isListen,
          glowColor: Colors.red,
          endRadius: 65.0,
          duration: Duration(milliseconds: 2000),
          repeatPauseDuration: Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            child: Icon(isListen ? Icons.mic : Icons.mic_none),
            onPressed: () {
              listen();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }
}
