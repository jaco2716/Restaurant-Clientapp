import 'package:flutter/material.dart';
import 'package:restaurantclientapp/logic/CalculateValues.dart';
import 'package:restaurantclientapp/Model/MenuItem.dart';

class OrderConfirmation extends StatelessWidget {
  final List<MenuItem> cartItems;
  OrderConfirmation(this.cartItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ordre',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              buildCart(cartItems),
              Divider(
                thickness: 3,
                height: 2,
                color: Colors.yellow,
              ),
              ListTile(
                title: Text(
                  'Total',
                  style: totalpriceStyle(),
                ),
                trailing: Text(
                  '${CalculateValues.totalPriceFromOrder(cartItems)} kr,-',
                  style: totalpriceStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle totalpriceStyle() {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  Widget buildCart(List<MenuItem> menuItem) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 10),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: menuItem.length,
      itemBuilder: (BuildContext context, int index) {
        return cartTile(menuItem[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 2,
          color: Colors.blue,
        );
      },
    );
  }

  Widget cartTile(MenuItem menuItem) {
    //menuItem.meatChoice.forEach((element) {print(element.toString());});
    int totalItemPrice = menuItem.price * menuItem.amount;
    List<int> totalMeatChoicePrice = [];
    if (menuItem.meatChoice.length != 0) {
      menuItem.meatChoice.forEach((meat) {
        totalMeatChoicePrice.add(meat.price * meat.amount);
      });
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 2),
      title: Text('${menuItem.amount.toString()}x  ${menuItem.title}'),
      // leading: Text(
      //   '${menuItem.amount.toString()}',
      // ),
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
                          Text(
                            '+ ${totalMeatChoicePrice[meatIndex].toString()}kr,-',
                          ),
                        ]),
                      )
                    : Container();
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            )
          : null,
      trailing: Text(totalItemPrice.toString() + ' kr,-\n'),
      dense: true,
    );
  }
}
