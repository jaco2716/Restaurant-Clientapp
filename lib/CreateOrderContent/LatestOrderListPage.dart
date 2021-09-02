import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurantclientapp/Model/MealsLog.dart';
import 'package:restaurantclientapp/Model/Order.dart';
import '../flavors.dart';
import 'LatestOrderRow.dart';

class LatestOrderListPage extends StatefulWidget {
  final int orderLimit;

  LatestOrderListPage(this.orderLimit);

  @override
  _LatestOrderListPageState createState() => _LatestOrderListPageState();
}

class _LatestOrderListPageState extends State<LatestOrderListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LatestOrderRow(),
        Divider(),
        StreamBuilder<QuerySnapshot>(
          //TODO change from testorders
            stream: _firestore
                .collection('${F.firestoreCollection}/orders')
                .orderBy('acceptTime', descending: true)
                .limit(widget.orderLimit)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Text("You have no new orders");
              else if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  List<Order> orders = [];

                  snapshot.data?.docs.forEach((e) {
                    Order dataOrder = Order.fromJson(e.data() as Map<String, dynamic>);

                    if (!dataOrder.orderDone) orders.add(dataOrder);
                  });
                  final int dataCount = orders.length;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: dataCount,
                      itemBuilder: (_, int index) {
                        return LatestOrderRow(order: orders[index]);
                      },
                    ),
                  );
              }
            }),
      ],
    );
  }
}
