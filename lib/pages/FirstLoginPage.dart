import 'package:flutter/material.dart';
import 'package:restaurantclientapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstLoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: Colors.blue[100],
                child: Container(
                  width: 400,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: TextFormField(
                    onSaved: (value) => _password = value,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      icon: Icon(Icons.person),
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: 400,
                height: 80,
                child: RaisedButton(
                    child: Text('Login'),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form?.save();

                      if (_password == 'j201295') {
                        saveIsLoggedIn(true);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => MyApp()),
                            (route) => false);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveIsLoggedIn(bool loggedIn) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setBool('isLoggedIn', loggedIn);
  }
}
