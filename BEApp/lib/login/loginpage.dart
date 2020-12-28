import 'dart:math';

import 'package:bank_easy/login/OTPscreen.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNo;
  int _otp, _minOtpValue, _maxOtpValue; //Generated OTP

  void generateOtp([int min = 1000, int max = 9999]) {
    //Generates four digit OTP by default
    _minOtpValue = min;
    _maxOtpValue = max;
    _otp = _minOtpValue + Random().nextInt(_maxOtpValue - _minOtpValue);
  }

  void sendOtp(String phoneNumber,
      [String messageText,
      int min = 1000,
      int max = 9999,
      String countryCode = '+91']) {
    //function parameter 'message' is optional.
    generateOtp(min, max);
    SmsSender sender = new SmsSender();
    String address = (countryCode ?? '+1') + phoneNumber;

    sender.sendSms(new SmsMessage(
        address, messageText ?? 'Your OTP is : ' + _otp.toString()));
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
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      Image.asset(
                        'images/logowhite.png',
                        height: 140,
                        width: 140,
                      ),
                    ],
                  )),
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "Welcome! Enter your mobile number to get started.",
                            style: TextStyle(color: Colors.white)),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              this.phoneNo = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                        ),
                        RaisedButton(
                          onPressed: () {
                            sendOtp(phoneNo);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    OTPScreen(phoneNo, _otp)));
                          },
                          child: Text('SUBMIT', style: TextStyle(fontSize: 20)),
                          textColor: Colors.white,
                          elevation: 7,
                          color: Color(0xffe2b113),
                        )
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
