import 'package:flutter/material.dart';
import 'package:restaurantclientapp/CreateOrderContent/CartItemsBottomSheet.dart';
import 'package:restaurantclientapp/CreateOrderContent/ConfirmDetailsPage.dart';
import 'package:restaurantclientapp/Model/MealsLog.dart';
import 'package:restaurantclientapp/Model/MenuItem.dart';

class NewOrderCart extends StatefulWidget {
  final ValueChanged<int> notifyParent;

  NewOrderCart(this.notifyParent);

  @override
  _NewOrderCartState createState() => _NewOrderCartState();
}

class _NewOrderCartState extends State<NewOrderCart> {
  List<MenuItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    cartItems.clear();
    //TODO = DONE? ChangeTo final Static lists
    // addToCart(MealsLog.smallMeals);
    // addToCart(MealsLog.soups);
    // addToCart(MealsLog.noodlesAndFriedRice);
    // addToCart(MealsLog.mainMealWithRice);
    // addToCart(MealsLog.specialMealsWithRice);
    // addToCart(MealsLog.vegetaryVeganMeals);
    // addToCart(MealsLog.salads);
    // addToCart(MealsLog.childMeals);
    // addToCart(MealsLog.accessoriesItems);

    int subtotal = 0;
    cartItems.forEach((element) {
      int meatChoiceTotal = 0;
      int meatTotalAmount = 0;
      if (element.meatChoice.length != 0) {
        element.meatChoice.forEach((meat) {
          meatTotalAmount += meat.amount;
          meatChoiceTotal += meat.price * meat.amount;
        });
        print('item: ' + element.amount.toString());
        print('meat: ' + meatTotalAmount.toString());
        if (element.amount < meatTotalAmount) {
          print('run');
          element.meatChoice.forEach((meat2) => meat2.amount = 0);
          meatChoiceTotal = 0;
        }
      }
      subtotal += element.price * element.amount + meatChoiceTotal;
    });
    MealsLog.totalPrice = subtotal;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Kurv'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
            widget.notifyParent(0);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(child: cartItems.length > 0 ? buildCart(cartItems) : emptyCart()),
          ),
          ListTile(
            title: Text('Total'),
            trailing: Text(subtotal.toString() + ' kr,-'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: cartItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmDetailsPage(cartItems)));
                        },
                  child: Text('Gå til bestilling')),
            ),
          )
        ],
      ),
    );
  }

  updateWidgets() {
    print('update');
    setState(() {});
  }

  Widget emptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.shopping_basket,
          color: Colors.grey[300],
          size: 150,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Din kurv er tom'),
        ),
      ],
    );
  }

  void addToCart(List<MenuItem> menuItems) {
    menuItems.forEach((element) {
      if (element.amount != 0) {
        MenuItem newElement = MenuItem(
            id: element.id,
            title: element.title,
            description: element.description,
            price: element.price,
            image: element.image,
            amount: element.amount,
            meatChoice: element.meatChoice);
        cartItems.add(newElement);
      }
    });
  }

  Widget buildCart(List<MenuItem> menuItem) {
    return Container(
      child: ListView.separated(
        itemCount: menuItem.length,
        itemBuilder: (BuildContext context, int index) {
          return menuItem[index].amount > 0 ? cartTile(menuItem[index]) : Center();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 2,
            color: Colors.blue,
          );
        },
      ),
    );
  }

  Widget cartTile(MenuItem menuItem) {
    int totalItemPrice = menuItem.price * menuItem.amount;
    int totalMeatChoiceAmount = 0;
    List<int> totalMeatChoicePrice = [];
    if (menuItem.meatChoice.length != 0) {
      menuItem.meatChoice.forEach((meat) {
        totalMeatChoicePrice.add(meat.price * meat.amount);
        totalMeatChoiceAmount += meat.amount;
      });
    }
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(children: [
          ListTile(
              title: Text("Nr.${menuItem.id} - ${menuItem.title}"),
              subtitle: menuItem.meatChoice.length != 0
                  ? totalMeatChoiceAmount < 1
                      ? Text('Tryk her for andet kød/vegetar.')
                      : ListView.builder(
                          itemCount: menuItem.meatChoice.length,
                          itemBuilder: (BuildContext context, int meatIndex) {
                            print('meatamount: ' + menuItem.meatChoice[meatIndex].amount.toString());
                            return menuItem.meatChoice[meatIndex].amount != 0
                                ? Container(
                                    height: 35,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Text(
                                        ' - ${menuItem.meatChoice[meatIndex].amount}x ${menuItem.meatChoice[meatIndex].title}',
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
              leading: Container(padding: EdgeInsets.all(10), color: Colors.brown[100], child: Text(menuItem.amount.toString() + 'x')),
              trailing: Text(totalItemPrice.toString() + ' kr,-\n'),
              onTap: () {
                showCartBottomSheet(context, menuItem);
              }),
        ]),
      ),
    );
  }

  showCartBottomSheet(BuildContext context, MenuItem menuItem) {
    print('open modal');
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return CartItemsBottomSheet(
            context,
            menuItem,
            notifyParent: _refreshFromParent,
          );
        });
  }

  _refreshFromParent(int i) {
    setState(() {});
  }
}
