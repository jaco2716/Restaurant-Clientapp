import 'package:flutter/material.dart';
import 'package:restaurantclientapp/CreateOrderContent/CreateNewOrderPage.dart';
import 'package:restaurantclientapp/Model/MealsLog.dart';
import 'package:restaurantclientapp/Model/MenuItem.dart';
import 'package:restaurantclientapp/Model/Order.dart';

import '../logic/CalculateValues.dart';

class EditSingleOrderPage extends StatelessWidget {
  Order order;

  EditSingleOrderPage(this.order);

  @override
  Widget build(BuildContext context) {
    // updateFromEditOrder(MealsLog.smallMeals, order.menuOrder);
    // updateFromEditOrder(MealsLog.soups, order.menuOrder);
    // updateFromEditOrder(MealsLog.noodlesAndFriedRice, order.menuOrder);
    // updateFromEditOrder(MealsLog.mainMealWithRice, order.menuOrder);
    // updateFromEditOrder(MealsLog.specialMealsWithRice, order.menuOrder);
    // updateFromEditOrder(MealsLog.vegetaryVeganMeals, order.menuOrder);
    // updateFromEditOrder(MealsLog.salads, order.menuOrder);
    // updateFromEditOrder(MealsLog.childMeals, order.menuOrder);
    // updateFromEditOrder(MealsLog.accessoriesItems, order.menuOrder);
    //print('update mealslog');

    return Scaffold(
      appBar: AppBar(
        title: Text('Rediger Ordre'),
        leading: IconButton(
          onPressed: () {
            CalculateValues.resetMenuItems();
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: CreateNewOrderPage(
        true,
        editOrder: order,
      ),
    );
  }

  // resetMenuItems() {
  //   print('reset');
  //   MealsLog.totalPrice = 0;
  //   //TODO = DONE? Change to final static lists
  //   clearMenuItems(MealsLog.smallMeals);
  //   clearMenuItems(MealsLog.soups);
  //   clearMenuItems(MealsLog.noodlesAndFriedRice);
  //   clearMenuItems(MealsLog.mainMealWithRice);
  //   clearMenuItems(MealsLog.specialMealsWithRice);
  //   clearMenuItems(MealsLog.vegetaryVeganMeals);
  //   clearMenuItems(MealsLog.salads);
  //   clearMenuItems(MealsLog.childMeals);
  //   clearMenuItems(MealsLog.accessoriesItems);
  // }

  // void clearMenuItems(List<MenuItem> menuItems) {
  //   menuItems.forEach((element) {
  //     element.amount = 0;
  //     if(element.meatChoice.length != 0)element.meatChoice.forEach((meatelement) => meatelement.amount = 0);
  //   });
  // }

  void updateFromEditOrder(List<MenuItem> mealLogItems, List<MenuItem> editItems) {
    for (var i = 1; i <= mealLogItems.length; i++) {
      editItems.forEach((editElement) {
        if (mealLogItems[i - 1].id == editElement.id) mealLogItems[i - 1] = MenuItem.clone(editElement);
      });
    }
  }
}
