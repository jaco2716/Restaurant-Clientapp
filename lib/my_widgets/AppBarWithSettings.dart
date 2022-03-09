import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:restaurantclientapp/Model/ApplicationData.dart';
import 'package:restaurantclientapp/my_widgets/MyLoadingCircle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flavors.dart';

class AppBarWithSettings extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final bool isHomePage;
  final String deviceID;
  final ValueChanged<int> notifyParent;
  AppBarWithSettings(this._title, {this.isHomePage = false, this.deviceID = '', required this.notifyParent});
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: isHomePage
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    notifyParent(1);
                  },
                  child: Image.asset('assets/ilmolino/icons/iconlight.png'),
                ),
              )
            : null,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.green[900],
        title: Text(_title),
        actions: isHomePage
            ? <Widget>[
                IconButton(
                    icon: Icon(Icons.settings, color: Colors.green[800]),
                    onPressed: () {
                      _buildNotiDialog(context, 'Info', deviceID);
                    }),
              ]
            : null);
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

  Future _buildNotiDialog(BuildContext context, String _title, String thisDeviceID) async {
    String status = '';
    String printerStatus = '';
    TextEditingController tec = TextEditingController();
    ScrollController _scrollController = ScrollController();
    tec.text = '192.168.0.';

    return showDialog(
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 16, left: 16, right: 16),
          buttonPadding: EdgeInsets.all(0),

          // title: Text(_title),
          content: StatefulBuilder(builder: (BuildContext context, setModalState) {
            // String printerIP =

            return SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                width: 650,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder(
                      future: _loadPrinterIP(),
                      initialData: 'Printer IP',
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        String printIpText = '';
                        if (snapshot.connectionState == ConnectionState.waiting)
                          printIpText = 'Printer IP:           ';
                        else
                          printIpText = 'Printer IP: ' + snapshot.data;
                        return Text(printIpText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center);
                      },
                    ),

                    Container(
                      width: 200,
                      child: TextField(
                          keyboardType: TextInputType.number,
                          controller: tec,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(fillColor: Colors.grey[200], filled: true)),
                    ),
                    Text(printerStatus),
                    ElevatedButton(
                      child: Text('Gem ny printer IP'),
                      onPressed: () {
                        if (tec.text.length >= 11) {
                          _savePrinterIP(tec.text);
                          printerStatus = 'Printer IP gemt.';
                        } else {
                          printerStatus = 'Ugyldig IP.';
                          print('Invalid ip');
                        }
                        setModalState(() {});
                      },
                    ),
                    Divider(thickness: 1),
                    Text('Device Notification ID:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                    Text(thisDeviceID, style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text('Online Notification ID:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                    FutureBuilder<DocumentSnapshot>(
                      future: _firestore.doc('${F.firestoreCollection}').get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        String deviceNotiID = '';
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return MyLoadingCircle(50);
                        else {
                          ApplicationData appData = ApplicationData.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                          deviceNotiID = appData.deviceToken;
                        }
                        return Column(
                          children: [
                            Text(deviceNotiID, style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                            Divider(thickness: 1),
                            thisDeviceID != deviceNotiID
                                ? Text(
                                    'Device Notification ID og Online Notification ID skal være det samme.\nTryk på "Opdater Notifikations ID" hvis de ikke stemmer overens.',
                                    style: TextStyle(fontSize: 12, color: Colors.red),
                                    textAlign: TextAlign.center,
                                  )
                                : Center(),
                          ],
                        );
                      },
                    ),
                    ElevatedButton(
                        child: Text('Opdater notifikations ID'),
                        onPressed: () async {
                          await _firestore.doc('${F.firestoreCollection}').set({
                            'deviceToken': thisDeviceID,
                          }, SetOptions(merge: true)).then((value) {
                            print('db: success!');
                            setModalState(
                              () {
                                status = 'Success!\nNotifikationer tilmeldt.';
                              },
                            );
                          }).catchError(
                            (onError) {
                              print('db error: ' + onError.toString());
                              setModalState(() {
                                status = 'Der skete en fejl, prøv igen senere. \nEller kontakt Wejeo for manuel tilmelding.';
                              });
                            },
                          );
                        }),
                    ElevatedButton(
                      child: Text('Kopier ID'),
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(text: thisDeviceID));

                        setModalState(
                          () {
                            status = 'ID kopieret.';
                          },
                        );
                      },
                    ),
                    Text(status, textAlign: TextAlign.center),

                    // ElevatedButton(
                    //   child: Text('Tilmeld'),
                    //   onPressed: () {
                    //   _firebaseMessaging.subscribeToTopic('orders').then((value) {
                    //     setModalState(() {
                    //       title = 'Success!\nNotifikationer tilmeldt.';
                    //     });
                    //     print('topic is orders');
                    //   }).catchError((onError) {
                    //     setModalState(() {
                    //       title = 'Fejl, prøv igen senere.';
                    //     });
                    //     print(onError.toString());
                    //   });
                    // })
                  ],
                ),
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

  static Future<void> _savePrinterIP(String printerIP) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setString('printerIP', printerIP);
  }

  static Future<String> _loadPrinterIP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('printerIP') ?? '');
  }

//   Future<bool> postToFireStore(Order finalOrder, String orderDate) async {
//     //print('Sending to db');

//     List<Map<String, dynamic>> finalMenuOrder = List<Map<String, dynamic>>();
//     finalOrder.menuOrder.forEach((element) {
//       finalMenuOrder.add(element.toJson());
//     });

//     //TODO Change from testorders
//     var docpostRef = _firestore.collection(MealsLog.forestoreOrderCollection);

//     await docpostRef.document(orderDate).setData({
//       'menuOrder': finalMenuOrder,
//       'user': finalOrder.user.toJson(),
//       'orderDate': finalOrder.orderDate,
//       'orderDone': finalOrder.orderDone,
//       'orderAccepted': finalOrder.orderAccepted,
//       'acceptTime': finalOrder.acceptTime,
//       'restaurantMessage': finalOrder.restaurantMessage,
//       'orderMessage': finalOrder.orderMessage,
//     }).then((value) {
//       print('db: success!');
//       return true;
//     }).catchError((onError) {
//       print('db error: ' + onError.toString());
//       return false;
//     });
//     return false;
//   }
}
