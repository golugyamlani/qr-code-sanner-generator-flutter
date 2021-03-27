import 'package:flutter/material.dart';
import 'package:qr_code_buddy/scan_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_buddy/resuable_card.dart';
import 'package:qr_code_buddy/constants.dart';
import 'package:qr_code_buddy/icon_content.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: Text(
                    'QR Code \nScanner & Generator',
                    style: kLabelTextStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: ReusableCard(
                colour: kCardColour,
                cardChild: Center(
                  child: QrImage(
                    data: "Hello World",
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ReusableCard(
                      colour: kCardColour,
                      cardChild: IconContent(
                        icon: Icons.qr_code_scanner,
                        label: 'Scan',
                      ),
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          '/scan',
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kCardColour,
                      cardChild: IconContent(
                        icon: Icons.qr_code,
                        label: 'Generate',
                      ),
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          '/generate',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
