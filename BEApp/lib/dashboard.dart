import 'package:bank_easy/atmQR/QRhome.dart';
import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GridView(
//       children: <Widget>[
//         Card(
//           elevation: 10,
//           child: Center(child: Text('Cash Deposit')),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: EdgeInsets.symmetric(
//             vertical: 8,
//             horizontal: 4,
//           ),
//         ),
//         Card(
//           elevation: 10,
//           child: Center(child: Text('Cash Withdrawal')),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: EdgeInsets.symmetric(
//             vertical: 8,
//             horizontal: 4,
//           ),
//         ),
//       ],
//       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 200,
//         childAspectRatio: 3 / 2,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 20,
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.qr_code_scanner_rounded),
                            color: Colors.black,
                            iconSize: 30.0,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            }),
                        Spacer(),
                        Image.asset(
                          'images/logo.png',
                          height: 140,
                          width: 140,
                        ),
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.person),
                            color: Colors.black,
                            iconSize: 30.0,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            }),
                      ])),
                ),
                Expanded(
                  flex: 7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QRhome()));
                        },
                        child: Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFFf3b91c),
                                Color(0xFFd18808),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: const Text('Cash Withdrawal',
                                style: TextStyle(
                                  fontSize: 15.5,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        textColor: Colors.white,
                        color: Colors.white,
                      ),
                      SizedBox(width: 40),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QRhome()));
                        },
                        child: Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFFf3b91c),
                                Color(0xFFd18808),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: const Text('Cash Deposition',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        textColor: Colors.white,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
