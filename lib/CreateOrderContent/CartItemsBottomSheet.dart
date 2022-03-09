import 'package:flutter/material.dart';
import 'package:restaurantclientapp/Model/MenuItem.dart';

class CartItemsBottomSheet extends StatefulWidget {
  final MenuItem menuItem;
  final BuildContext bContext;
  final ValueChanged<int> notifyParent;

  CartItemsBottomSheet(this.bContext, this.menuItem, {required this.notifyParent});

  @override
  _CartItemsBottomSheetState createState() => _CartItemsBottomSheetState();
}

class _CartItemsBottomSheetState extends State<CartItemsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    int itemAmount = widget.menuItem.amount;
    return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
      int totalExtraMeat = 0;
      if (widget.menuItem.meatChoice.length != 0) {
        widget.menuItem.meatChoice.forEach((element) {
          totalExtraMeat += element.amount;
          print('meat: ${element.amount}');
        });
      }
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
                    widget.menuItem.meatChoice.length == 0
                        ? Center()
                        : Column(children: [
                            Text('Vælg andet end kylling'),
                            ListView.builder(
                              itemCount: widget.menuItem.meatChoice.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 40,
                                  width: double.infinity,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                                    title: Text('${widget.menuItem.meatChoice[index].title}  +${widget.menuItem.meatChoice[index].price}kr,-'),
                                    trailing: Container(
                                      width: 130,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(Icons.remove),
                                              iconSize: 30,
                                              color: Colors.red,
                                              onPressed: () {
                                                if (widget.menuItem.meatChoice[index].amount >= 1) {
                                                  setModalState(() {
                                                    widget.menuItem.meatChoice[index].amount--;
                                                  });
                                                }
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(widget.menuItem.meatChoice[index].amount.toString()),
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.add),
                                              iconSize: 30,
                                              color: Colors.green,
                                              onPressed: () {
                                                if (totalExtraMeat < itemAmount) {
                                                  setModalState(() {
                                                    widget.menuItem.meatChoice[index].amount++;
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
                                  widget.menuItem.meatChoice.forEach((element) => element.amount = 0);
                                });
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(itemAmount.toString(), textScaleFactor: 3),
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
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45),
                      ),
                      child: Text('Fjern fra ordre'),
                      onPressed: () {
                        widget.notifyParent(0);

                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                      ),
                      child: Text('Færdig'),
                      onPressed: () {
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

  // void updateOrder(List<MenuItem> menuItems, MenuItem newItem, int newAmount) {
  //   menuItems.forEach((element) {
  //     if (element.id == newItem.id) {
  //       element.amount = newAmount;
  //       if (newAmount == 0 && element.meatChoice.length != 0) {
  //         element.meatChoice.forEach((element) => element.amount = 0);
  //       }
  //     }
  //   });
  // }
}
