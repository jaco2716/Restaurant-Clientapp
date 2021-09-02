import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../logic/CalculateValues.dart';
import '../../Model/Order.dart';
import '../../SingleOrderContent/SingleOrderPage.dart';
import '../../flavors.dart';

class OrderListRow extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Order? order;
  final bool isAllOrders;

  OrderListRow(this.isAllOrders, {this.order});
  @override
  Widget build(BuildContext context) {
    Color? cardColor = Colors.white;
    String orderNr = 'Ordre Nr';
    String name = 'Navn';
    String dateString = 'Bestillingstid';
    String pickupTime = 'Afhent tid';
    Icon deleteIcon = Icon(Icons.delete, color: Colors.grey[200]);
    Icon statusIcon = Icon(Icons.watch_later, color: Colors.orange,);
    double elevate = 0;
    TextStyle textStyle = TextStyle();
    if (order != null) {
      orderNr = order!.orderDate;
      name = order!.user.fullName;

      dateString = CalculateValues.dateStringFromMili(order!.orderDate);
      if (int.parse(order!.acceptTime) > 10) {
        pickupTime = CalculateValues.dateStringFromMili(order!.acceptTime);
      } else {
        pickupTime = 'Ikke valgt';
      }

      elevate = 5;
      if (order!.orderAccepted) {
        deleteIcon = Icon(Icons.delete, color: Colors.red);
        statusIcon = Icon(Icons.check_circle, color: Colors.white);
        cardColor = Colors.green[700];
        textStyle = TextStyle(color: Colors.white);
      } else if (order!.orderDone) {
        statusIcon = Icon(Icons.cancel_rounded, color: Colors.white);
        cardColor = Colors.red[700];
        textStyle = TextStyle(color: Colors.white);
      } else {
        // statusIcon = Icon(Icons.watch_outlined, color: Colors.orange);
        cardColor = Colors.white;
      }
    }

    return Container(
      decoration: BoxDecoration(
      color: cardColor,
        border: Border.all(color: Colors.grey[200]!)
      ),
      // elevation: elevate,
      child: InkWell(
        child: Container(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 60, child: order != null? statusIcon : Text('  Status')),
              SizedBox(width: 120, child: Text(orderNr, style: textStyle)),
              SizedBox(width: 240, child: Text(name, style: textStyle)),
              SizedBox(width: 100, child: Text(dateString, style: textStyle)),
              SizedBox(width: 100, child: Text(pickupTime, style: textStyle)),
              !isAllOrders
                  ? SizedBox(
                      width: 50,
                      child: IconButton(
                        icon: deleteIcon,
                        onPressed: () {
                          if (order != null) {
                            if (order!.orderAccepted) {
                              //TODO Change from testorders
                              _firestore.collection('${F.firestoreCollection}/orders').doc(order!.orderDate).update({'orderDone': true});
                            }
                          }
                        },
                      ))
                  : Center(),
            ],
          ),
        ),
        onTap: () {
          if (order != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SingelOrderPage(order!, dateString), fullscreenDialog: true));
          }
        },
      ),
    );
  }
}
