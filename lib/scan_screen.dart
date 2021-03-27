import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:qr_code_buddy/constants.dart';
import 'package:qr_code_buddy/icon_content.dart';
import 'package:qr_code_buddy/resuable_card.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String barcode = "";

  get onPressed => null;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   title: new Text('QR Code Scanner'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_sharp),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Qr Code Scanner',
                    style: kLabelTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
              child: ReusableCard(
                colour: kCardColour,
                cardChild: IconContent(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera Access',
                ),
                onPress: scan,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Expanded(
            child: ReusableCard(
              colour: kCardColour,
              cardChild: Center(
                child: Text(
                  barcode,
                  style: kDisplayTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          // ElevatedButton(
          //   onPressed: scan,
          //   child: Text('Start Camera Scan'),
          // ),
          // Text(
          //   barcode,
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
