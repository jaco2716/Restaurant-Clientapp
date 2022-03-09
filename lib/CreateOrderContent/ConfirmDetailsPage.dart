import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurantclientapp/Model/MealsLog.dart';
import 'package:restaurantclientapp/Model/MenuItem.dart';
import 'package:restaurantclientapp/Model/Order.dart';
import 'package:restaurantclientapp/Model/OrderUser.dart';
import '../logic/CalculateValues.dart';
import '../logic/PosPrinterHandler.dart';
import '../flavors.dart';
import '../pages/my_home_page.dart';
import 'LatestOrderListPage.dart';
import 'OrderConfirmation.dart';

class ConfirmDetailsPage extends StatefulWidget {
  final List<MenuItem> cartItems;

  ConfirmDetailsPage(this.cartItems);

  @override
  _ConfirmDetailsPageState createState() => _ConfirmDetailsPageState();
}

class _ConfirmDetailsPageState extends State<ConfirmDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController myController = TextEditingController();
  String orderMessage = 'Ingen kommentar til restaurenten.';
  String serverToken =
      'AAAALduRePU:APA91bHXoPXMG7XmhwiPfl1GxuSyn5ds47H_sbNVbk9RZQv0F4c9OY4Xa9w8HtMgpRszJk2i5qSCVz2deJJ0zDI72Y3SP-r7uczK4L3R0YxF1TEuQCqKGAt4PTv-s3tL9q-sqdTbMMvd';
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _phoneNr;
  int hourAmount = 0;
  int minuteAmount = 15;
  int collectDateRounded = 0;
  bool isTogo = true;

  @override
  Widget build(BuildContext context) {
    int tempDateNow = DateTime.now().millisecondsSinceEpoch - 59000;
    collectDateRounded = tempDateNow + 300000 - tempDateNow % 300000;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: Text('Senest afhentningstid'),
          ),
          onPressed: () {
            _buildLatestOrdersDialog(context);
          },
        ),
      ),
      appBar: AppBar(
        title: Text('Bekræft Ordre'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Card(
                          color: Colors.blue[100],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            child: TextFormField(
                              onSaved: (value) => _name = value,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                //prefixText: 'Navn og evt. Bord nr.',
                                labelText: 'Navn og evt. Bord nr.',
                                border: InputBorder.none,
                                //hintText: "Navn og evt. Bord nr.",
                                icon: Icon(Icons.person),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.blue[100],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            child: TextFormField(
                              onSaved: (value) => _phoneNr = value,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Tlf nr.',
                                border: InputBorder.none,
                                //hintText: "Tlf nr.",
                                icon: Icon(Icons.person),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: (MediaQuery.of(context).size.width / 2) - 50, child: OrderConfirmation(widget.cartItems)),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 50,
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              padding: EdgeInsets.all(4),
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: Colors.blue,
                                  ),
                                  child: Text('Tilføj kommentar til ordren.'),
                                  onPressed: () {
                                    _buildAddMessageDialog(context);
                                  }),
                            ),
                            Card(
                                elevation: 5,
                                child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    child: Column(children: [
                                      Text(
                                        'Kommentar:',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        orderMessage,
                                        textAlign: TextAlign.center,
                                      ),
                                    ]))),
                            Container(
                              height: 60,
                              padding: EdgeInsets.all(4),
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  child: Text('Vælg afhent tidspunkt'),
                                  onPressed: () {
                                    showCartBottomSheet(context);
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  'Kan hentes om $hourAmount timer og $minuteAmount min.\nKl: ${CalculateValues.dateStringFromMili((collectDateRounded + ((minuteAmount + (hourAmount * 60)) * 60000)).toString())}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                                'Spis her',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Switch(
                                  value: isTogo,
                                  onChanged: (value) {
                                    setState(() {
                                      isTogo = value;
                                    });
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                              ),
                              Text(
                                'To go',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4),
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        // confirmOrder();
                        onConfirmPressed();
                      },
                      child: Text('Godkend')),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//Skal måske bruges senere, hvis man skal vælge hvornår man vil hente maden.
  // _buildSelectTime() {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         color: Colors.white,
  //         height: 200,
  //         child: CupertinoDatePicker(
  //           use24hFormat: true,
  //           initialDateTime: isOpen? currentDate : todayOpenDate,
  //           minimumDate: isOpen? currentDate : todayOpenDate,
  //           maximumDate: todayClosingDate,
  //           minuteInterval: 1,
  //           mode: CupertinoDatePickerMode.dateAndTime,
  //           onDateTimeChanged: (DateTime dateTime) {
  //             print("dateTime: $dateTime");
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  //dialog to add comment to order.
  _buildAddMessageDialog(BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Tilføj kommentar'),
          content: Container(
            width: 400,
            height: 120,
            color: Colors.grey[100],
            child: TextField(
              scrollPadding: EdgeInsets.all(0),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              maxLines: 5,
              controller: myController,
              //minLines: 3,
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text('Luk'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
                child: Text('Tilføj'),
                onPressed: () {
                  setState(() {
                    orderMessage = myController.text;
                  });
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

  _buildLatestOrdersDialog(BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Seneste Ordrer'),
          content: Container(
            color: Colors.grey[100],
            width: 200,
            height: 400,
            child: LatestOrderListPage(10),
          ),
          actions: <Widget>[
            TextButton(
                child: Text('Luk'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
      context: context,
    );
  }

  showCartBottomSheet(BuildContext context) {
    int collectMinuteAmount = minuteAmount;
    int collectHourAmount = hourAmount;
    int dateNow = DateTime.now().millisecondsSinceEpoch - 59000;

    int dateNowRounded = dateNow + 300000 - dateNow % 300000;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 350,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Hvornår maden kan hentes:', textScaleFactor: 1.5),
                    Text(
                        '${CalculateValues.dateStringFromMili((dateNowRounded + ((collectMinuteAmount + (collectHourAmount * 60)) * 60000)).toString())}',
                        textScaleFactor: 2.3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.remove),
                            iconSize: 35,
                            color: Colors.red,
                            onPressed: () {
                              if (collectHourAmount > 0) {
                                setModalState(() {
                                  collectHourAmount -= 1;
                                });
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(collectHourAmount.toString() + ' Timer', textScaleFactor: 3),
                        ),
                        IconButton(
                            icon: Icon(Icons.add),
                            iconSize: 35,
                            color: Colors.green,
                            onPressed: () {
                              setModalState(() {
                                collectHourAmount += 1;
                              });
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.remove),
                            iconSize: 35,
                            color: Colors.red,
                            onPressed: () {
                              if (collectMinuteAmount > 0) {
                                setModalState(() {
                                  collectMinuteAmount -= 5;
                                });
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(collectMinuteAmount.toString() + ' Min', textScaleFactor: 3),
                        ),
                        IconButton(
                            icon: Icon(Icons.add),
                            iconSize: 35,
                            color: Colors.green,
                            onPressed: () {
                              if (collectMinuteAmount < 55) {
                                setModalState(() {
                                  collectMinuteAmount += 5;
                                });
                              }
                            }),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Opdater Tidspunkt'),
                      onPressed: () {
                        setState(() {
                          minuteAmount = collectMinuteAmount;
                          hourAmount = collectHourAmount;
                          collectDateRounded = dateNowRounded;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void onConfirmPressed() {
    // showDialog(
    //   builder: (context) {
    //     return AlertDialog(
    //       elevation: 0,
    //       backgroundColor: Colors.transparent,
    //       content: Center(child: CircularProgressIndicator()),
    //     );
    //   },
    //   context: context,
    // );

    try {
      final form = _formKey.currentState;
      form!.save();

      String finalName = _name ?? 'Admin';
      finalName += finalName.length < 1 ? 'Admin' : '';
      finalName += isTogo ? ' - To go' : ' - Spiser her';
      String finalPhone = _phoneNr ?? 'Admin';
      finalPhone += finalPhone.length < 1 ? 'Admin' : '';

      OrderUser user = OrderUser(
        uid: 'Admin',
        email: 'Admin',
        fullName: finalName,
        phoneNr: finalPhone,
      );

      String acceptDate = (collectDateRounded + ((minuteAmount + (hourAmount * 60)) * 60000)).toString();
      //Create Order
      String orderDate = DateTime.now().millisecondsSinceEpoch.toString();
      Order finalOrder = Order(
          menuOrder: widget.cartItems,
          user: user,
          orderDate: orderDate,
          orderDone: false,
          orderAccepted: true,
          acceptTime: acceptDate,
          wantOrderTime: '',
          restaurantMessage: 'No message',
          orderMessage: orderMessage);

      confirmOrder(finalOrder, orderDate);

      MealsLog.pageIndex = 0;

//TODO change to scaffold messenger
      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false);

      print('Success????');
    } catch (e) {
      Navigator.of(context).pop();
      print('Caught error');
      print('Error: ${e.toString()}');
      _buildDialog(context, 'Der skete en fejl', 'Der kan ikke forbindes til serveren.');
    }
  }

//Bekræft og send ordre button
  void confirmOrder(Order finalOrder, String orderDate) async {
    PosPrinterHandler.printOrder(finalOrder, context, false);
    await postToFireStore(finalOrder, orderDate);
    CalculateValues.resetMenuItems();
  }

  Future _buildDialog(BuildContext context, String _title, String _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(
            _title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            _message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

//Send order to database
  Future<bool> postToFireStore(Order finalOrder, String orderDate) async {
    //print('Sending to db');

    List<Map<String, dynamic>> finalMenuOrder = [];
    finalOrder.menuOrder.forEach((element) {
      finalMenuOrder.add(element.toJson());
    });

    //TODO Change from testorders
    var docpostRef = _firestore.collection('${F.firestoreCollection}/orders');

    await docpostRef.doc(orderDate).set({
      'menuOrder': finalMenuOrder,
      'user': finalOrder.user.toJson(),
      'orderDate': finalOrder.orderDate,
      'orderDone': finalOrder.orderDone,
      'orderAccepted': finalOrder.orderAccepted,
      'acceptTime': finalOrder.acceptTime,
      'restaurantMessage': finalOrder.restaurantMessage,
      'orderMessage': finalOrder.orderMessage,
    }).then((value) {
      print('db: success!');
      return true;
    }).catchError((onError) {
      print('db error: ' + onError.toString());
      return false;
    });
    return false;
  }
}
