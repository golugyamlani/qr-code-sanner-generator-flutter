import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateScreen extends StatefulWidget {
  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  String _dataString = "Hello from this QR";
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Screen'),
      ),
      body: contentWidget(),
    );
  }

  contentWidget() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Your Text",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _dataString = _textController.text;
                  });
                },
                child: Text("SUBMIT"),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: QrImage(
                data: _dataString,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
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
