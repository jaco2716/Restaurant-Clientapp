import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurantclientapp/Model/MenuItem.dart';
import 'package:restaurantclientapp/Model/Order.dart';

import '../logic/CalculateValues.dart';
import '../logic/PosPrinterHandler.dart';
import '../flavors.dart';
import 'EditSingleOrderPage.dart';

class SingelOrderPage extends StatefulWidget {
  final Order order;
  final String dateString;

  SingelOrderPage(this.order, this.dateString);

  @override
  _SingelOrderPageState createState() => _SingelOrderPageState();
}

class _SingelOrderPageState extends State<SingelOrderPage> {
  int minuteAmount = 15;
  int hourAmount = 0;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String orderDoneText = '';
  TextEditingController _textEditingController = TextEditingController();
  DocumentReference? docRef;

  @override
  Widget build(BuildContext context) {
    // print('meeet '+widget.order.menuOrder[0].meatChoice[0].amount.toString());
    //TODO change from testorders
    docRef = _firestore.collection('${F.firestoreCollection}/orders').doc(widget.order.orderDate);
    //print(widget.order.restaurantMessage);
    if (widget.order.orderAccepted)
      orderDoneText =
          'Ordren blev accepteret. \n Afhent kl: ${CalculateValues.dateStringFromMili(widget.order.acceptTime)}\n\nBesked:\n${widget.order.restaurantMessage}';
    else if (widget.order.orderDone) orderDoneText = 'Ordren blev afvist med besked: \n${widget.order.restaurantMessage}';

    return Scaffold(
      // appBar: AppBarLeo('Ordre Nr: ${widget.order.orderDate}'),
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Ordre Nr: ${widget.order.orderDate}'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // widget.notifyParent(0);
            Navigator.of(context).pop();
          },
        ),
        actions: [
          (widget.order.orderDone || widget.order.orderAccepted)
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text('Fortryd Bestilling'),
                  onPressed: () {
                    restoreOrder();
                  })
              : Center()
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width / 2),
              child: Card(
                elevation: 15,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Navn: ${widget.order.user.fullName}'),
                        subtitle: Text('Tlf: ${widget.order.user.phoneNr} \nE-mail: ${widget.order.user.email}'),
                      ),
                      Divider(),
                      Text('Bestilt ${widget.dateString}'),
                      widget.order.orderAccepted || widget.order.orderDone ? orderAcceptedWidgets() : acceptOrderWidgets(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width / 2) - 50,
              child: Card(
                elevation: 15,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.order.menuOrder.length,
                        itemBuilder: (_, int index) {
                          return OrderItemListTile(widget.order.menuOrder[index]);
                        },
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      Divider(),
                      Text(
                        'Total pris: ${CalculateValues.totalPriceFromOrder(widget.order.menuOrder)} kr,-',
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(),
                      Text(
                        'Kommentar:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(widget.order.orderMessage),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text('Rediger ordre'),
                        onPressed: () {
                          CalculateValues.resetMenuItems();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditSingleOrderPage(widget.order), fullscreenDialog: true));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderAcceptedWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          widget.order.orderAccepted ? Icon(Icons.check_circle, size: 60, color: Colors.green) : Icon(Icons.cancel, size: 60, color: Colors.red),
          Text(
            orderDoneText,
            textAlign: TextAlign.center,
          ),
          widget.order.orderAccepted
              ? IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.print),
                  onPressed: () {
                    PosPrinterHandler.printOrder(widget.order, context, true);
                  })
              : Center()
        ],
      ),
    );
  }

  Widget acceptOrderWidgets() {
    return Column(
      children: [
        Text(
            'Kan hentes om $hourAmount timer og $minuteAmount min.\nKl: ${CalculateValues.dateStringFromMili((DateTime.now().millisecondsSinceEpoch + ((minuteAmount + (hourAmount * 60)) * 60000)).toString())}',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            child: Text('Vælg afhænt tidspunkt'),
            onPressed: () {
              showCartBottomSheet(context);
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Accepter'),
              onPressed: acceptOrder,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('    Afvis    '),
              onPressed: declineOrder,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            color: Colors.grey[200],
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none, hintText: 'Skriv kommentar til kunden.'),
              scrollPadding: EdgeInsets.all(0),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              maxLines: 5,
              controller: _textEditingController,
              //minLines: 3,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          child: Text('Vi har travlt og tager ikke imod flere bestillinger i dag.'),
          onPressed: () {
            setState(() {
              _textEditingController.text = 'Vi har travlt og tager ikke imod flere bestillinger i dag.';
            });
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          child: Text('Ring til os angående din bestilling.'),
          onPressed: () {
            setState(() {
              _textEditingController.text = 'Ring til os angående din bestilling.';
            });
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          child: Text('Vi har desværre lukket for i dag.'),
          onPressed: () {
            setState(() {
              _textEditingController.text = 'Vi desværre lukket for i dag.';
            });
          },
        )
      ],
    );
  }

  showCartBottomSheet(BuildContext context) {
    int collectMinuteAmount = minuteAmount;
    int collectHourAmount = hourAmount;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Hvornår maden kan hentes', textScaleFactor: 1.5),
                    Text('Timer'),
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

  void restoreOrder() async {
    await docRef!
        .update({
          'acceptTime': '0',
          'orderAccepted': false,
          'orderDone': false,
        })
        .then((value) => print('Restore Success'))
        .catchError((error) => print('Restore error'));
    setState(() {
      widget.order.acceptTime = '0';
      widget.order.orderAccepted = false;
      widget.order.orderDone = false;
    });
  }

  void acceptOrder() async {
    _textEditingController.text == null || _textEditingController.text.length < 1
        ? widget.order.restaurantMessage = 'Ingen besked.'
        : widget.order.restaurantMessage = _textEditingController.text;
    String date = (DateTime.now().millisecondsSinceEpoch + ((minuteAmount + (hourAmount * 60)) * 60000)).toString();
    await docRef!
        .update({'acceptTime': date, 'orderAccepted': true, 'restaurantMessage': widget.order.restaurantMessage})
        .then((value) => print('Accept Success'))
        .catchError((error) => print('Accept error'));

    setState(() {
      widget.order.acceptTime = date;
      widget.order.orderAccepted = true;
    });
    PosPrinterHandler.printOrder(widget.order, context, false);
  }

  void declineOrder() async {
    _textEditingController.text == null
        ? widget.order.restaurantMessage = 'Ingen besked.'
        : widget.order.restaurantMessage = _textEditingController.text;
    await docRef!
        .update({
          'acceptTime': '1',
          'orderDone': true,
          'restaurantMessage': widget.order.restaurantMessage,
        })
        .then((value) => print('Decline Success'))
        .catchError((error) => print('Decline error'));

    setState(() {
      widget.order.acceptTime = '1';
      widget.order.orderDone = true;
    });
  }
}

class OrderItemListTile extends StatelessWidget {
  final MenuItem menuItem;
  const OrderItemListTile(this.menuItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(menuItem.id.toString()),
      title: Text(menuItem.title),
      subtitle: menuItem.meatChoice.length != 0
          ? ListView.builder(
              itemCount: menuItem.meatChoice.length,
              itemBuilder: (BuildContext context, int meatIndex) {
                // print('meatamount: ' +
                //     menuItem.meatChoice[meatIndex].amount.toString());
                return menuItem.meatChoice[meatIndex].amount != 0
                    ? Container(
                        height: 35,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            '     - ${menuItem.meatChoice[meatIndex].amount}x ${menuItem.meatChoice[meatIndex].title}',
                          ),
                        ]),
                      )
                    : Container();
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            )
          : null,
      trailing: Text(menuItem.amount.toString() + 'x'),
    );
  }
}
