import 'package:bank_easy/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRhome extends StatefulWidget {
  @override
  _QRhomeState createState() => _QRhomeState();
}

class _QRhomeState extends State<QRhome> {
  String scanResult = '';

  //function that launches the scanner
  Future scanQRCode() async {
    String cameraScanResult = await scanner.scan();
    setState(() {
      scanResult = cameraScanResult;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.white,
                            iconSize: 30.0,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            }),
                        Spacer(
                          flex: 4,
                        ),
                        Image.asset(
                          'images/logowhite.png',
                          height: 140,
                          width: 140,
                        ),
                        Spacer(),
                      ])),
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: scanQRCode,
                          child: Text('SCAN', style: TextStyle(fontSize: 20)),
                          textColor: Colors.black,
                          elevation: 7,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                          "Align the QR Code displayed in the ATM screen \nto the middle of the scanner\n to initiate session",
                          style: TextStyle(color: Colors.white)),
                    ],
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
