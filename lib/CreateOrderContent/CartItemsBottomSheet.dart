import 'package:flutter/material.dart';
import 'package:restaurantclientapp/Model/MenuItem.dart';

class CartItemsBottomSheet extends StatefulWidget {
  MenuItem menuItem;
  BuildContext bContext;
  final ValueChanged<int> notifyParent;

  CartItemsBottomSheet(this.bContext, this.menuItem, {required this.notifyParent});

  @override
  _CartItemsBottomSheetState createState() => _CartItemsBottomSheetState();
}

class _CartItemsBottomSheetState extends State<CartItemsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    int itemAmount = widget.menuItem.amount;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      int totalExtraMeat = 0;
      if (widget.menuItem.meatChoice != null) {
        widget.menuItem.meatChoice.forEach((element) {
          totalExtraMeat += element.amount;
          print('meat: ${element.amount}');
        });
      }
      //print(widget.menuItem.meatChoice.toString());
      // widget.menuItem.meatChoice.forEach((element) {
      //   totalExtraMeat += element.amount;
      // });
      // modalMeatChoice.forEach((element) {
      //   totalExtraMeat += element.amount;
      // });
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Wrap(children: [
          Center(
            child: Container(
              width: 400,
              //height: 600,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.menuItem.meatChoice == null
                        ? Center()
                        : Column(children: [
                            Text('Vælg andet end kylling'),
                            ListView.builder(
                              itemCount: widget.menuItem.meatChoice.length,
                              itemBuilder: (BuildContext context, int index) {
                                // if (firstOpen) {
                                //   modalMeatChoice.forEach((element) =>
                                //       tempMeatChoice.add(element));
                                //   firstOpen = false;
                                // }
                                return Container(
                                  height: 40,
                                  width: double.infinity,
                                  //color: Colors.red,
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    title: Text(
                                        '${widget.menuItem.meatChoice[index].title}  +${widget.menuItem.meatChoice[index].price}kr,-'),
                                    trailing: Container(
                                      width: 130,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(Icons.remove),
                                              iconSize: 30,
                                              color: Colors.red,
                                              onPressed: () {
                                                if (widget
                                                        .menuItem
                                                        .meatChoice[index]
                                                        .amount >=
                                                    1) {
                                                  setModalState(() {
                                                    widget
                                                        .menuItem
                                                        .meatChoice[index]
                                                        .amount--;
                                                  });
                                                }
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(widget.menuItem
                                                .meatChoice[index].amount
                                                .toString()),
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.add),
                                              iconSize: 30,
                                              color: Colors.green,
                                              onPressed: () {
                                                if (totalExtraMeat <
                                                    itemAmount) {
                                                  setModalState(() {
                                                    widget
                                                        .menuItem
                                                        .meatChoice[index]
                                                        .amount++;
                                                  });
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            ),
                          ]),
                    Text(widget.menuItem.title, textScaleFactor: 1.5),
                    Text(widget.menuItem.price.toString() + ' kr,-'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.remove),
                            iconSize: 35,
                            color: Colors.red,
                            onPressed: () {
                              if (itemAmount > 1) {
                                setModalState(() {
                                  itemAmount--;
                                  widget.menuItem.meatChoice
                                      .forEach((element) => element.amount = 0);
                                });
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:
                              Text(itemAmount.toString(), textScaleFactor: 3),
                        ),
                        IconButton(
                            icon: Icon(Icons.add),
                            iconSize: 35,
                            color: Colors.green,
                            onPressed: () {
                              setModalState(() {
                                itemAmount++;
                              });
                            }),
                      ],
                    ),
                    FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 45),
                      child: Text('Fjern fra ordre'),
                      textColor: Colors.red,
                      onPressed: () {
                        //TODO = DONE? ChangeTo final Static lists
                        // updateOrder(MealsLog.smallMeals, widget.menuItem, 0);
                        // updateOrder(MealsLog.soups, widget.menuItem, 0);
                        // updateOrder(
                        //     MealsLog.noodlesAndFriedRice, widget.menuItem, 0);
                        // updateOrder(
                        //     MealsLog.mainMealWithRice, widget.menuItem, 0);
                        // updateOrder(
                        //     MealsLog.specialMealsWithRice, widget.menuItem, 0);
                        // updateOrder(
                        //     MealsLog.vegetaryVeganMeals, widget.menuItem, 0);
                        // updateOrder(MealsLog.salads, widget.menuItem, 0);
                        // updateOrder(MealsLog.childMeals, widget.menuItem, 0);
                        // updateOrder(
                        //     MealsLog.accessoriesItems, widget.menuItem, 0);

                        //setState(() {});
                        widget.notifyParent(0);

                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                      child: Text('Færdig'),
                      onPressed: () {
                        //TODO = DONE? ChangeTo final Static lists
                        // updateOrder(
                        //     MealsLog.smallMeals, widget.menuItem, itemAmount);
                        // updateOrder(
                        //     MealsLog.soups, widget.menuItem, itemAmount);
                        // updateOrder(MealsLog.noodlesAndFriedRice,
                        //     widget.menuItem, itemAmount);
                        // updateOrder(MealsLog.mainMealWithRice, widget.menuItem,
                        //     itemAmount);
                        // updateOrder(MealsLog.specialMealsWithRice,
                        //     widget.menuItem, itemAmount);
                        // updateOrder(MealsLog.vegetaryVeganMeals,
                        //     widget.menuItem, itemAmount);
                        // updateOrder(
                        //     MealsLog.salads, widget.menuItem, itemAmount);
                        // updateOrder(
                        //     MealsLog.childMeals, widget.menuItem, itemAmount);
                        // updateOrder(MealsLog.accessoriesItems, widget.menuItem,
                        //     itemAmount);

                        //setState(() {});
                        widget.notifyParent(0);

                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
    });
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

/*



*/
