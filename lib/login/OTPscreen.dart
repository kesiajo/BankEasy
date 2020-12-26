import 'package:bank_easy/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final int otp;
  OTPScreen(this.phone, this.otp);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  // String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

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
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Enter the 4-digit OTP sent to the entered number.",
                          style: TextStyle(color: Colors.white)),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: PinPut(
                          fieldsCount: 4,
                          textStyle: const TextStyle(
                              fontSize: 25.0, color: Colors.black),
                          eachFieldWidth: 40.0,
                          eachFieldHeight: 55.0,
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          submittedFieldDecoration: pinPutDecoration,
                          selectedFieldDecoration: pinPutDecoration,
                          followingFieldDecoration: pinPutDecoration,
                          pinAnimationType: PinAnimationType.fade,
                          onSubmit: (pin) {
                            if (int.parse(pin) == widget.otp) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Home()));
                            } else {
                              FocusScope.of(context).unfocus();
                              _scaffoldkey.currentState.showSnackBar(
                                  SnackBar(content: Text('invalid OTP')));
                            }
                            // try {
                            //   await FirebaseAuth.instance
                            //       .signInWithCredential(
                            //           PhoneAuthProvider.credential(
                            //               verificationId: _verificationCode,
                            //               smsCode: pin))
                            //       .then((value) async {
                            //     if (value.user != null) {
                            //       Navigator.pushAndRemoveUntil(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => Home()),
                            //           (route) => false);
                            //     }
                            //   });
                            // }
                            // catch (e) {
                            //   FocusScope.of(context).unfocus();
                            //   _scaffoldkey.currentState.showSnackBar(
                            //       SnackBar(content: Text('invalid OTP')));
                            // }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
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

  // _verifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: '+91${widget.phone}',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => Home()),
  //                 (route) => false);
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String verficationID, int resendToken) {
  //         setState(() {
  //           _verificationCode = verficationID;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID) {
  //         setState(() {
  //           _verificationCode = verificationID;
  //         });
  //       },
  //       timeout: Duration(seconds: 120));
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _verifyPhone();
  // }
}
