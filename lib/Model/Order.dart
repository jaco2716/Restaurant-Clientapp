import 'dart:convert';

import 'MenuItem.dart';
import 'OrderUser.dart';

class Order {
  List<MenuItem> menuOrder;
  String orderDate;
  bool orderDone;
  bool orderAccepted;
  String acceptTime;
  String wantOrderTime;
  OrderUser user;
  String restaurantMessage;
  String orderMessage;

  Order({
    required this.menuOrder,
    required this.orderDate,
    required this.orderDone,
    required this.orderAccepted,
    required this.user,
    required this.restaurantMessage,
    required this.acceptTime,
    required this.wantOrderTime,
    required this.orderMessage,
  });

  Order.clone(Order orderCopy)
      : this(
            menuOrder: orderCopy.menuOrder,
            user: orderCopy.user,
            orderDate: orderCopy.orderDate,
            orderDone: orderCopy.orderDone,
            orderAccepted: orderCopy.orderAccepted,
            acceptTime: orderCopy.acceptTime,
            wantOrderTime: orderCopy.wantOrderTime,
            restaurantMessage: orderCopy.restaurantMessage,
            orderMessage: orderCopy.orderMessage);

  Order.fromJson(Map<String, dynamic> json)
      : menuOrder = (json['menuOrder'] as List).map((e) => MenuItem.fromJson(e)).toList(),
        orderDate = json['orderDate'],
        orderDone = json['orderDone'],
        orderAccepted = json['orderAccepted'],
        acceptTime = json['acceptTime'],
        wantOrderTime = json['wantOrderTime'] ?? '0',
        restaurantMessage = json['restaurantMessage'],
        orderMessage = json['orderMessage'],
        user = OrderUser.fromJson(json['user']);

  Map<String, dynamic> toJson() => {
        'menuOrder': jsonEncode(menuOrder),
        'orderDate': orderDate,
        'orderDone': orderDone,
        'orderAccepted': orderAccepted,
        'acceptTime': acceptTime,
        'wantOrderTime': wantOrderTime,
        'restaurantMessage': restaurantMessage,
        'orderMessage': orderMessage,
        'user': user.toJson(),
      };
}
