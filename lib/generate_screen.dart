import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

class GenerateScreen extends StatefulWidget {
  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  String _dataString = "Hello from this QR";
  final TextEditingController _textController = TextEditingController();
  static GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Screen'),
      ),
      body: contentWidget(),
    );
  }

  Future<Null> shareGeneratedQR() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      if (boundary.debugNeedsPaint) {
        Timer(Duration(seconds: 1), () => shareGeneratedQR());
        return null;
      }
      ui.Image image = await boundary.toImage();
      final directory = (await getExternalStorageDirectory()).path;
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.jpg');
      imgFile.writeAsBytes(pngBytes);
      // print('Screenshot Path:' + imgFile.path);
      final RenderBox box = context.findRenderObject();
      Share.shareFiles(
        ['$directory/screenshot.jpg'],
        // subject: 'Screenshot + Share',
        // text: 'Hey, check it out the QR!',
        // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
  }

  contentWidget() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Text",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _dataString = _textController.text;
                    print(_dataString);
                  });
                },
                child: Text("SUBMIT"),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'QR Code',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: QrImage(
                          data: _dataString,
                        ),
                      ),
                    ),
                    Text('Hello World'),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: shareGeneratedQR,
            child: Row(
              children: [
                Icon(Icons.share),
                Text('Share'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
