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
      if (element.meatChoice != null) {
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
              child: RaisedButton(
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
    if (menuItem.meatChoice != null) {
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
              subtitle: menuItem.meatChoice != null
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
    int itemAmount = menuItem.amount;
    // List<MeatChoice> modalMeatChoice = new List<MeatChoice>();
    // modalMeatChoice.clear();
    print('open modal');

    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          // if (menuItem.id > 5 && menuItem.id < 8)
          //   soupMeatChoice.forEach((element) => modalMeatChoice.add(MeatChoice(element.title, element.price, element.value, element.amount)));
          // else if (menuItem.id > 7 && menuItem.id < 11)
          //   noodleAndFriedRiceMeatChoice
          //       .forEach((element) => modalMeatChoice.add(MeatChoice(element.title, element.price, element.value, element.amount)));
          // else if (menuItem.id > 10 && menuItem.id < 21)
          //   mainMealWithRiceMeatChoice
          //       .forEach((element) => modalMeatChoice.add(element));

          //print(modalMeatChoice.length);
          return CartItemsBottomSheet(
            context,
            menuItem,
            notifyParent: _refreshFromParent,
          );
          // return StatefulBuilder(
          //     builder: (BuildContext context, StateSetter setModalState) {
          //   int totalExtraMeat = 0;
          //   if (menuItem.meatChoice != null) {
          //     menuItem.meatChoice.forEach((element) {
          //       totalExtraMeat += element.amount;
          //       print('meat: ${element.amount}');
          //     });
          //   }
          //   //print(menuItem.meatChoice.toString());
          //   // menuItem.meatChoice.forEach((element) {
          //   //   totalExtraMeat += element.amount;
          //   // });
          //   // modalMeatChoice.forEach((element) {
          //   //   totalExtraMeat += element.amount;
          //   // });
          //   return Padding(
          //     padding: const EdgeInsets.all(30.0),
          //     child: Wrap(children: [
          //       Center(
          //         child: Container(
          //           width: 400,
          //           //height: 600,
          //           child: Center(
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 menuItem.meatChoice == null
          //                     ? Center()
          //                     : Column(children: [
          //                         Text('Vælg andet end kylling'),
          //                         ListView.builder(
          //                           itemCount: menuItem.meatChoice.length,
          //                           itemBuilder:
          //                               (BuildContext context, int index) {
          //                             // if (firstOpen) {
          //                             //   modalMeatChoice.forEach((element) =>
          //                             //       tempMeatChoice.add(element));
          //                             //   firstOpen = false;
          //                             // }
          //                             return Container(
          //                               height: 40,
          //                               width: double.infinity,
          //                               //color: Colors.red,
          //                               child: ListTile(
          //                                 contentPadding: EdgeInsets.symmetric(
          //                                     horizontal: 4),
          //                                 title: Text(
          //                                     '${menuItem.meatChoice[index].title}  +${menuItem.meatChoice[index].price}kr,-'),
          //                                 trailing: Container(
          //                                   width: 130,
          //                                   child: Row(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment.center,
          //                                     children: <Widget>[
          //                                       IconButton(
          //                                           icon: Icon(Icons.remove),
          //                                           iconSize: 30,
          //                                           color: Colors.red,
          //                                           onPressed: () {
          //                                             if (menuItem
          //                                                     .meatChoice[index]
          //                                                     .amount >=
          //                                                 1) {
          //                                               setModalState(() {
          //                                                 menuItem
          //                                                     .meatChoice[index]
          //                                                     .amount--;
          //                                               });
          //                                             }
          //                                           }),
          //                                       Padding(
          //                                         padding: const EdgeInsets.all(
          //                                             12.0),
          //                                         child: Text(menuItem
          //                                             .meatChoice[index].amount
          //                                             .toString()),
          //                                       ),
          //                                       IconButton(
          //                                           icon: Icon(Icons.add),
          //                                           iconSize: 30,
          //                                           color: Colors.green,
          //                                           onPressed: () {
          //                                             if (totalExtraMeat <
          //                                                 itemAmount) {
          //                                               setModalState(() {
          //                                                 menuItem
          //                                                     .meatChoice[index]
          //                                                     .amount++;
          //                                               });
          //                                             }
          //                                           }),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             );
          //                           },
          //                           physics: NeverScrollableScrollPhysics(),
          //                           shrinkWrap: true,
          //                         ),
          //                       ]),
          //                 Text(menuItem.title, textScaleFactor: 1.5),
          //                 Text(menuItem.price.toString() + ' kr,-'),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: <Widget>[
          //                     IconButton(
          //                         icon: Icon(Icons.remove),
          //                         iconSize: 35,
          //                         color: Colors.red,
          //                         onPressed: () {
          //                           if (itemAmount > 1) {
          //                             setModalState(() {
          //                               itemAmount--;
          //                               menuItem.meatChoice.forEach(
          //                                   (element) => element.amount = 0);
          //                             });
          //                           }
          //                         }),
          //                     Padding(
          //                       padding: const EdgeInsets.all(12.0),
          //                       child: Text(itemAmount.toString(),
          //                           textScaleFactor: 3),
          //                     ),
          //                     IconButton(
          //                         icon: Icon(Icons.add),
          //                         iconSize: 35,
          //                         color: Colors.green,
          //                         onPressed: () {
          //                           setModalState(() {
          //                             itemAmount++;
          //                           });
          //                         }),
          //                   ],
          //                 ),
          //                 FlatButton(
          //                   padding: EdgeInsets.symmetric(
          //                       vertical: 15, horizontal: 45),
          //                   child: Text('Fjern fra ordre'),
          //                   textColor: Colors.red,
          //                   onPressed: () {
          //                     //TODO = DONE? ChangeTo final Static lists
          //                     updateOrder(MealsLog.smallMeals, menuItem, 0);
          //                     updateOrder(MealsLog.soups, menuItem, 0);
          //                     updateOrder(
          //                         MealsLog.noodlesAndFriedRice, menuItem, 0);
          //                     updateOrder(
          //                         MealsLog.mainMealWithRice, menuItem, 0);
          //                     updateOrder(
          //                         MealsLog.specialMealsWithRice, menuItem, 0);
          //                     updateOrder(
          //                         MealsLog.vegetaryVeganMeals, menuItem, 0);
          //                     updateOrder(MealsLog.salads, menuItem, 0);
          //                     updateOrder(MealsLog.childMeals, menuItem, 0);
          //                     updateOrder(
          //                         MealsLog.accessoriesItems, menuItem, 0);

          //                     setState(() {});

          //                     Navigator.pop(context);
          //                   },
          //                 ),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 RaisedButton(
          //                   padding: EdgeInsets.symmetric(
          //                       vertical: 15, horizontal: 70),
          //                   child: Text('Færdig'),
          //                   onPressed: () {
          //                     //TODO = DONE? ChangeTo final Static lists
          //                     updateOrder(
          //                         MealsLog.smallMeals, menuItem, itemAmount);
          //                     updateOrder(MealsLog.soups, menuItem, itemAmount);
          //                     updateOrder(MealsLog.noodlesAndFriedRice,
          //                         menuItem, itemAmount);
          //                     updateOrder(MealsLog.mainMealWithRice, menuItem,
          //                         itemAmount);
          //                     updateOrder(MealsLog.specialMealsWithRice,
          //                         menuItem, itemAmount);
          //                     updateOrder(MealsLog.vegetaryVeganMeals, menuItem,
          //                         itemAmount);
          //                     updateOrder(
          //                         MealsLog.salads, menuItem, itemAmount);
          //                     updateOrder(
          //                         MealsLog.childMeals, menuItem, itemAmount);
          //                     updateOrder(MealsLog.accessoriesItems, menuItem,
          //                         itemAmount);

          //                     setState(() {});
          //                     Navigator.pop(context);
          //                   },
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ]),
          //   );
          // });
        });
  }

  _refreshFromParent(int i) {
    setState(() {});
  }

  void updateOrder(List<MenuItem> menuItems, MenuItem newItem, int newAmount) {
    menuItems.forEach((element) {
      if (element.id == newItem.id) {
        element.amount = newAmount;
        if (newAmount == 0 && element.meatChoice != null) {
          element.meatChoice.forEach((element) => element.amount = 0);
        }
      }
    });
  }
}
