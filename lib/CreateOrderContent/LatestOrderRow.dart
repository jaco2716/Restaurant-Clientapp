import 'package:flutter/material.dart';
import 'package:restaurantclientapp/logic/CalculateValues.dart';
import 'package:restaurantclientapp/Model/Order.dart';

class LatestOrderRow extends StatelessWidget {
  //final Firestore _firestore = Firestore.instance;
  final Order? order;

  LatestOrderRow({this.order});
  @override
  Widget build(BuildContext context) {
    Color? cardColor = Colors.white;
    String pickupTime = 'Afhent tid';
    double elevate = 0;
    if (order != null) {

      if(int.parse(order!.acceptTime) > 10){
        pickupTime = CalculateValues.dateStringFromMili(order!.acceptTime);
      } else {
        pickupTime = 'Ikke valgt';
      }
      
      elevate = 5;
      if (order!.orderAccepted)
        cardColor = Colors.green[100];
      else if (order!.orderDone)
        cardColor = Colors.red[100];
      else
        cardColor = Colors.white;
    }

    return Card(
      color: cardColor,
      elevation: elevate,
      child: Container(
        height: 55,
        child: Center(child: Text(pickupTime)),
      ),
    );
  }
}
