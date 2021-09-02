import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Model/Order.dart';
import 'OrderListRow.dart';
import '../../flavors.dart';

class OrderListPage extends StatefulWidget {
  final bool isAllOrders;
  //final int orderLimit;

  OrderListPage(this.isAllOrders);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderListRow(widget.isAllOrders),
        Divider(),
        StreamBuilder<QuerySnapshot>(
          //TODO Change from testorders
            stream: _firestore
                .collection('${F.firestoreCollection}/orders')
                .orderBy('orderDate', descending: true)
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
                    if (!widget.isAllOrders) {
                      if (!dataOrder.orderDone) orders.add(dataOrder);
                    } else {
                      orders.add(dataOrder);
                    }
                  });
                  final int dataCount = orders.length;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: dataCount,
                      itemBuilder: (_, int index) {
                        return OrderListRow(widget.isAllOrders, order: orders[index]);
                      },
                    ),
                  );
              }
            }),
      ],
    );
  }
}
