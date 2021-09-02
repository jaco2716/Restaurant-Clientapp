import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../my_widgets/AppBarWithSettings.dart';
import '../logic/CalculateValues.dart';
import '../CreateOrderContent/CreateNewOrderPage.dart';
import '../Model/FcmNotification.dart';
import '../Model/MealsLog.dart';
import '../Model/Order.dart';
import 'order_list_content/OrderListPage.dart';
import '../SingleOrderContent/SingleOrderPage.dart';
import '../flavors.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _navIndex = 0;
  String deviceToken = 'Fejl, prøv igen.';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
//TODO notificationss...
    // _firebaseMessaging
    //     .subscribeToTopic('orders')
    //     .then((value) => print('topic is orders'))
    //     .catchError((onError) {
    //   _buildErrorDialog(context, 'Notification error',
    //       'Kunne ikke give adgang til notifikationer');
    //   print(onError.toString());
    // });
    // _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //   setState(() {
    //     deviceToken = token;
    //   });
    //   print("Push Messaging token: $deviceToken");
    // });

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     await showNotiDialog(message);
    //   },
    //   //onBackgroundMessage: null,
    //   onBackgroundMessage: Platform.isAndroid ? Fcm.myBackgroundMessageHandler : null,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     await openOrderFromNoti(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     await openOrderFromNoti(message);
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //   setState(() {
    //     deviceToken = token;
    //   });
    //   print("Push Messaging token: $deviceToken");
    // });
    _firebaseMessagingSetup();
    loginMethod();
  }

  _firebaseMessagingSetup() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    _firebaseMessaging.getToken().then((token) {
      if (token != null) {
        setState(() {
          deviceToken = token;
        });
      }
      print("Push Messaging token: $deviceToken");
    });
  }

  showNotiDialog(Map<String, dynamic> message) async {
    //TODO play noti sound
    // AudioPlayer player = await audioPlayer.play('LeosWokSound.mp3');
    setState(() {});
    FcmNotification notificationData = FcmNotification.fromJson(message);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Ny Ordre"),
              content: Container(
                width: 400,
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Order Nr",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${notificationData.id}\n\n\n"),
                    Text(
                      'Tidspunkt',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('${CalculateValues.dateStringFromMili(notificationData.id)}'),
                  ],
                ),
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 200,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text('Close me!'),
                      onPressed: () {
                        // player.stop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  width: 210,
                  height: 50,
                  child: RaisedButton(
                      child: Text('Go to order'),
                      onPressed: () {
                        // player.stop();
                        Navigator.of(context).pop();
                        openOrderFromNoti(message);
                      }),
                ),
              ],
            ));
  }

  Future openOrderFromNoti(Map<String, dynamic> message) async {
    //TODO Change from testorders
    var docRef = _firestore.collection('${F.firestoreCollection}/orders');
    FcmNotification noti = FcmNotification.fromJson(message);
    print('Noti ID:' + noti.id);
    DocumentSnapshot<Map<String, dynamic>> data = await docRef.doc(noti.id).get();
    Order notiOrder = Order.fromJson(data.data()!);
    List<String> dateTimeList = DateTime.fromMillisecondsSinceEpoch(int.parse(notiOrder.orderDate)).toString().split(' ');
    List<String> dateList = dateTimeList[0].split('-');
    List<String> timeList = dateTimeList[1].split(':');
    String date = '${dateList[2]}/${dateList[1]}/${dateList[0]}';
    String time = '${timeList[0]}:${timeList[1]}';
    String dateString = '$time  $date';
    Navigator.push(context, MaterialPageRoute(builder: (context) => SingelOrderPage(notiOrder, dateString), fullscreenDialog: true));
  }

  loginMethod() async {
    try {
      Map<String, dynamic> adminUser = F.adminUser;
      User result = await loginUser(email: adminUser['email'], password: adminUser['password']);
      print('Result:  --  ' + result.toString());
      // }catch(error){
      //   print(error.toString());
      //   _buildErrorDialog(context, '_title', '_message');
      // }
    } on FirebaseAuthException catch (error) {
      // handle the firebase specific error
      return _buildErrorDialog(context, 'Login til databasen fejlede', error.message!);
    } catch (error) {
      // gracefully handle anything else that might happen..
      print(error.toString());
      return _buildErrorDialog(context, 'Login til databasen fejlede', "Noget gik galt, tjek internet forbindelsen og prøv igen.");
    }
  }

  Future _buildErrorDialog(BuildContext context, String _title, String _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Kunne ikke få adgang til databasen.'),
              Text('Besked: ' + _message),
            ],
          ),
          actions: <Widget>[
            FlatButton(
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

  Future<User> loginUser({required String email, required String password}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // print("User Logged in: " + result.user?.email!);
      // since something changed, let's notify the listeners...
      return result.user!;
    } catch (e) {
      print('AuthError: ' + e.toString());
      throw new FirebaseAuthException(code: 'Login error code', message: 'Login error message');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pageTabs = [
      //Center(child: Text('sa')),
      OrderListPage(false),
      //CreateOrderPage(),
      CreateNewOrderPage(false),
      OrderListPage(true)
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: MealsLog.pageIndex,
          items: [
            BottomNavigationBarItem(label: 'Udestående Ordrer', icon: Icon(Icons.list)),
            BottomNavigationBarItem(label: 'Ny Ordre', icon: Icon(Icons.add)),
            BottomNavigationBarItem(label: 'Alle Ordrer', icon: Icon(Icons.receipt))
          ],
          onTap: (index) {
            // SystemSound.play(SystemSoundType.click);
            setState(() {
              MealsLog.pageIndex = index;
            });
          },
        ),
        appBar: AppBarWithSettings(
          '${F.appTitle} Client App',
          isHomePage: true,
          deviceID: deviceToken,
          notifyParent: _refresh,
        ),
        body: pageTabs[MealsLog.pageIndex]);
  }

  _refresh(int index) {
    setState(() {
      MealsLog.pageIndex = index;
    });
  }
}
