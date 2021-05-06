import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart';

class Web extends StatefulWidget {
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  String _platformVersion = 'Unknown';
  FlutterBarcodeSdk _barcodeReader = FlutterBarcodeSdk();
  final _controller = TextEditingController();
  bool _isValid = false;
  String _file = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterBarcodeSdk.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Widget getDefaultImage() {
    if (_controller.text.isEmpty || !_isValid) {
      return Image.asset('images/default.png');
    } else {
      return Image.file(File(_file));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Dynamsoft Barcode Reader'),
          ),
          body: Column(children: [
            Container(
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                        child: Text('Barcode Scanner'),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () async {
                          _barcodeReader.decodeVideo();
                        }),
                  ]),
            ),
          ])),
    );
  }
}
