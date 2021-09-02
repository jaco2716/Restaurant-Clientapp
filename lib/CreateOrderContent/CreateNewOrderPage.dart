import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurantclientapp/Model/MealsLog.dart';
import 'package:restaurantclientapp/Model/MenuItem.dart';
import 'package:restaurantclientapp/Model/Order.dart';
import 'package:restaurantclientapp/SingleOrderContent/SingleOrderPage.dart';

import '../logic/CalculateValues.dart';
import 'CartItemsBottomSheet.dart';
import 'NewOrderCart.dart';

class CreateNewOrderPage extends StatefulWidget {
  final bool isEditOrder;
  final Order? editOrder;

  CreateNewOrderPage(this.isEditOrder, {this.editOrder});
  @override
  _CreateNewOrderPageState createState() => _CreateNewOrderPageState();
}

class _CreateNewOrderPageState extends State<CreateNewOrderPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<MenuItem> editCartItems = [];

  @override
  Widget build(BuildContext context) {
    // if (widget.isEditOrder && widget.editOrder != null) {
    //   print('update list');
    //   //TODO - Change to final static lists
    //   updateFromEditOrder(MealsLog.smallMeals, widget.editOrder.menuOrder);
    //   updateFromEditOrder(MealsLog.soups, widget.editOrder.menuOrder);
    //   updateFromEditOrder(
    //       MealsLog.noodlesAndFriedRice, widget.editOrder.menuOrder);
    //   updateFromEditOrder(
    //       MealsLog.mainMealWithRice, widget.editOrder.menuOrder);
    //   updateFromEditOrder(
    //       MealsLog.specialMealsWithRice, widget.editOrder.menuOrder);
    //   updateFromEditOrder(
    //       MealsLog.vegetaryVeganMeals, widget.editOrder.menuOrder);
    //   updateFromEditOrder(MealsLog.salads, widget.editOrder.menuOrder);
    //   updateFromEditOrder(MealsLog.childMeals, widget.editOrder.menuOrder);
    //   updateFromEditOrder(
    //       MealsLog.accessoriesItems, widget.editOrder.menuOrder);
    // }

    // print(MealsLog.smallMeals[0]);
    // print(widget.editOrder.menuOrder[0]);

    //print('show list');
    return Stack(children: [
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //TODO = DONE? ChangeTO final Static lists
                  // categoryTile('Små retter'),
                  // mealsGridView(MealsLog.smallMeals),
                  // categoryTile('Supper'),
                  // mealsGridView(MealsLog.soups),
                  // categoryTile('Nudler & stegte ris'),
                  // mealsGridView(MealsLog.noodlesAndFriedRice),
                  // categoryTile('Hovedretter med ris'),
                  // mealsGridView(MealsLog.mainMealWithRice),
                  // categoryTile('Specialretter med ris'),
                  // mealsGridView(MealsLog.specialMealsWithRice),
                  // categoryTile('Vegetar/Veganer retter'),
                  // mealsGridView(MealsLog.vegetaryVeganMeals),
                  // categoryTile('Salater'),
                  // mealsGridView(MealsLog.salads),
                  // categoryTile('Børne menu'),
                  // mealsGridView(MealsLog.childMeals),
                  // categoryTile('Tilbehør/Ekstra'),
                  // mealsGridView(MealsLog.accessoriesItems),
                ],
              ),
            ),
          ),
        ],
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: EdgeInsets.all(30),
          child: RaisedButton.icon(
            padding: EdgeInsets.all(20),
            label: Text(widget.isEditOrder ? 'Færdig' : 'Gå til kurv'),
            color: Colors.blue,
            icon:
                Icon(widget.isEditOrder ? Icons.check : Icons.shopping_basket),
            onPressed: () {
              _confirmBasket();
              // if (widget.isEditOrder) {
              //   editCartItems.clear();
              //   //TODO = DONE? ChangeTo final Static lists
              //   addToCart(MealsLog.smallMeals);
              //   addToCart(MealsLog.soups);
              //   addToCart(MealsLog.noodlesAndFriedRice);
              //   addToCart(MealsLog.mainMealWithRice);
              //   addToCart(MealsLog.specialMealsWithRice);
              //   addToCart(MealsLog.vegetaryVeganMeals);
              //   addToCart(MealsLog.salads);
              //   addToCart(MealsLog.childMeals);
              //   addToCart(MealsLog.accessoriesItems);
              //   await postToFireStore(
              //       editCartItems, widget.editOrder.orderDate);

              //   //widget.editOrder.menuOrder = editCartItems;

              //   CalculateValues.resetMenuItems();

              //   Navigator.of(context).pushAndRemoveUntil(
              //       MaterialPageRoute(
              //           builder: (context) => SingelOrderPage(
              //               widget.editOrder, widget.editOrder.orderDate),
              //           fullscreenDialog: true),
              //       ModalRoute.withName('/'));
              // } else {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               NewOrderCart(_refreshFromNotifyParent),
              //           fullscreenDialog: true));
              // }
            },
          ),
        ),
      )
      // Align(
      //   alignment: Alignment.bottomRight,
      //   child: Container(
      //         color: Colors.blue,
      //         height: 70,
      //         width: 200,
      //         child: ListTileTheme(
      //           textColor: Colors.white,
      //           iconColor: Colors.white,
      //           child: ListTile(
      //             leading: Icon(
      //               Icons.shopping_basket,
      //               size: 40,
      //             ),
      //             // title: Text(
      //             //     'Total: ${MealsLog.totalPrice != null ? MealsLog.totalPrice.toString() : '0'}kr,-'),
      //             title: Text('Gå til kurv'),
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) =>
      //                           NewOrderCart(_refreshFromNotifyParent),
      //                       fullscreenDialog: true));
      //             },
      //           ),
      //         ),
      //       ),
      // )
    ]);
  }

  Widget mealsGridView(List<MenuItem> menuItems) {
    return GridView.count(
      childAspectRatio: 1.1,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 5,
      children: List.generate(
        menuItems.length,
        (index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: GestureDetector(
              onTap: () {
                //_changeAmount(menuItems[index], 1);
                showCartBottomSheet(context, menuItems[index]);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Text(menuItems[index].id.toString(),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 50,
                        child: Text(
                          menuItems[index].title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(),
                      Text(menuItems[index].price.toString() + ',-'),
                      changeAmountButtons(menuItems[index])
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget categoryTile(String title) {
    return Container(
        color: Colors.teal[900],
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget changeAmountButtons(MenuItem meal) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Ink(
            decoration: ShapeDecoration(
              color: meal.amount > 0 ? Colors.red : Colors.grey,
              shape: CircleBorder(),
            ),
            child: IconButton(
              onPressed: () => _changeAmount(meal, -1),
              icon: Icon(Icons.remove),
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(meal.amount.toString()),
          ),
          Ink(
            decoration: ShapeDecoration(
              color: Colors.green,
              shape: CircleBorder(),
            ),
            child: IconButton(
              onPressed: () => _changeAmount(meal, 1),
              icon: Icon(Icons.add),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _changeAmount(MenuItem meal, int op) {
    if (meal.amount > 0 || op > 0) {
      setState(() {
        MealsLog.totalPrice += (meal.price * op);
        meal.amount += op;
        if (meal.meatChoice != null && op < 0) {
          meal.meatChoice.forEach((e) {
            e.amount = 0;
          });
        }
      });
    }
  }

  _refreshFromNotifyParent(int) {
    setState(() {});
  }

  _confirmBasket() async {
    if (widget.isEditOrder) {
      editCartItems.clear();
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
      await postToFireStore(editCartItems, widget.editOrder!.orderDate);

      widget.editOrder!.menuOrder = editCartItems;


      CalculateValues.resetMenuItems();
      // print(widget.editOrder.menuOrder[0].meatChoice[0].amount);
      // print(editCartItems[0].meatChoice[0].amount);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  SingelOrderPage(widget.editOrder!, widget.editOrder!.orderDate),
              fullscreenDialog: true),
          ModalRoute.withName('/'));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewOrderCart(_refreshFromNotifyParent),
              fullscreenDialog: true));
    }
  }

  showCartBottomSheet(BuildContext context, MenuItem menuItem) {
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

  void addToCart(List<MenuItem> menuItems) {
    menuItems.forEach((element) {
      if (element.amount != 0) {
        MenuItem newElement = MenuItem.clone(element);
        // MenuItem newElement = MenuItem(element.id, element.title,
        //     element.description, element.price, element.image, element.amount,
        //     meatChoice: element.meatChoice);
        editCartItems.add(newElement);
      }
    });
  }

  // void updateFromEditOrder(
  //     List<MenuItem> mealLogItems, List<MenuItem> editItems) {
  //   for (var i = 1; i <= mealLogItems.length; i++) {
  //     editItems.forEach((editElement) {
  //       if (mealLogItems[i - 1].id == editElement.id)
  //         mealLogItems[i - 1] = editElement;
  //     });
  //   }
  // }

  Future<bool> postToFireStore(
      List<MenuItem> editCart, String orderDate) async {
    print('Sending to db');

    List<Map<String, dynamic>> finalMenuOrder = [];
    editCart.forEach((element) {
      finalMenuOrder.add(element.toJson());
    });

    //TODO Change from testorders
    var docpostRef = _firestore.collection('');

    await docpostRef.doc(orderDate).update({
      'menuOrder': finalMenuOrder,
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
