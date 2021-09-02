import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:restaurantclientapp/pages/FirstLoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/MealsLog.dart';
import 'flavors.dart';
import 'pages/my_home_page.dart';

// AudioCache audioPlayer = AudioCache();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  F.appFlavor = Flavor.ilmolino;
  MealsLog.allMenus = F.allMenus;
  MealsLog.menuCategoryCards = F.menuCategoryCards;
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  bool _isLoggedIn = false;
  Future<bool> _loadIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<Widget> loginOrGoHome() async {
    _isLoggedIn = await _loadIsLoggedIn();
    print(_isLoggedIn);

    return _isLoggedIn ? MyHomePage() : FirstLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonThemeData(buttonColor: Colors.green[800], textTheme: ButtonTextTheme.primary),
      ),
      // home: MyHomePage(),
      home: FutureBuilder(
          future: loginOrGoHome(),
          initialData: Scaffold(
            body: Center(
              child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
            ),
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return FirstLoginPage();
            else if (snapshot.hasError) return Scaffold(body: Text('Error: ${snapshot.error}'));
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Scaffold(
                  body: Center(
                    child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
                  ),
                );
              default:
                return snapshot.data;
            }
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}

