

import '../Model/MealsLog.dart';
import '../Model/MenuItem.dart';

class CalculateValues
 {

  static String dateStringFromMili(String orderDate){
    List<String> dateTimeList =
          DateTime.fromMillisecondsSinceEpoch(int.parse(orderDate))
              .toString()
              .split(' ');
      List<String> dateList = dateTimeList[0].split('-');
      List<String> timeList = dateTimeList[1].split(':');
      String date = '${dateList[2]}/${dateList[1]}/${dateList[0]}';
      String time = '${timeList[0]}:${timeList[1]}';

      return '$time  $date';
  }

  static int totalPriceFromOrder(List<MenuItem> items) {
    int total = 0;
    items.forEach((element) {
      int meatChoiceTotal = 0;
      if (element.meatChoice != null) {
        element.meatChoice.forEach((meat) {
          meatChoiceTotal += meat.price * meat.amount;
        });
      }
      total += element.price * element.amount + meatChoiceTotal;
      
    });
    return total;
  }

  static resetMenuItems() {
    //print('reset');
    MealsLog.totalPrice = 0;
    //TODO = DONE? Change to final static lists
    // clearMenuItems(MealsLog.smallMeals);
    // clearMenuItems(MealsLog.soups);
    // clearMenuItems(MealsLog.noodlesAndFriedRice);
    // clearMenuItems(MealsLog.mainMealWithRice);
    // clearMenuItems(MealsLog.specialMealsWithRice);
    // clearMenuItems(MealsLog.vegetaryVeganMeals);
    // clearMenuItems(MealsLog.salads);
    // clearMenuItems(MealsLog.childMeals);
    // clearMenuItems(MealsLog.accessoriesItems);
  }

  static void clearMenuItems(List<MenuItem> menuItems) {
    menuItems.forEach((element) {
      element.amount = 0;
      if(element.meatChoice != null)element.meatChoice.forEach((meatelement) => meatelement.amount = 0);
    });
  }
}