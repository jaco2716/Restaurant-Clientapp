import 'dart:convert' show utf8;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CalculateValues.dart';
import '../Model/Order.dart';
import 'NetworkAnalyzer.dart';

class PosPrinterHandler {
  static String? printerIP;
  static List<NetworkAddress> addresses =[];
  static bool isLoadingPrinterIP = false;

  static printOrder(
      Order order, BuildContext context, bool checkForPrinters) async {
    const esc = '\x1B';

    const reset = '$esc@'; // Initialize printer
    const underline = '$esc-1';
    //const noUnderline = '$esc-0';
    const whiteOnBlack = '${esc}4';
    const noWhiteOnBlack = '${esc}5';
    const doubleWide = '${esc}W1';
    const doubleHeight = '${esc}h1';
    // const tripleWide = '${esc}W2';
    // const tripleHeight = '${esc}h2';
    const cutPaper = '${esc}d3';

    List<int> bytes = [];
    bytes += reset.codeUnits;

    // bytes += doubleWide.codeUnits;
    // bytes += doubleHeight.codeUnits;

    List<String> nameList = order.user.fullName.split('-');
    bytes += underline.codeUnits;
    bytes += utf8.encode('${nameList[0]}\n');
    bytes += reset.codeUnits;
    bytes += utf8.encode('Order Nr: ${order.orderDate}\n');
    bytes += utf8.encode('Tlf: ${order.user.phoneNr}\n');

    bytes += doubleWide.codeUnits;
    bytes += doubleHeight.codeUnits;
    bytes += whiteOnBlack.codeUnits;
    if (nameList.last == " Spiser her")
      bytes += utf8.encode(' Spiser her \n');
    else
      bytes += utf8.encode(' To go \n');
    bytes += utf8.encode(
        ' ${CalculateValues.dateStringFromMili(order.acceptTime).split(' ')[0]} ');
    bytes += noWhiteOnBlack.codeUnits;
    bytes += utf8.encode(
        '  ${CalculateValues.dateStringFromMili(order.acceptTime).split(' ').last}\n');

    // bytes += whiteOnBlack.codeUnits;
    // bytes += tripleWide.codeUnits;
    // bytes += tripleHeight.codeUnits;
    // bytes += utf8.encode('      Order     \n');
    bytes += noWhiteOnBlack.codeUnits;

    // bytes += utf8.encode('_____________________\n');
    bytes += utf8.encode('\n');
    order.menuOrder.forEach((e) {
      //   bytes += tripleWide.codeUnits;
      // bytes += tripleHeight.codeUnits;
      String orderTitleWithoutSpecial;
      orderTitleWithoutSpecial = sortSpecialCharactors(e.title, 'ø', 'oe');
      orderTitleWithoutSpecial =
          sortSpecialCharactors(orderTitleWithoutSpecial, 'æ', 'ae');
      orderTitleWithoutSpecial =
          sortSpecialCharactors(orderTitleWithoutSpecial, 'å', 'aa');
      if (e.id < 32) {
        int totalMeat = 0;
        if (e.meatChoice != null) {

          e.meatChoice.forEach((meatEle) {
            totalMeat += meatEle.amount;
            if (meatEle.amount > 0) {
              String meatTitleWithoutSpecial;
              meatTitleWithoutSpecial =
                  sortSpecialCharactors(meatEle.title, 'ø', 'oe');
              meatTitleWithoutSpecial =
                  sortSpecialCharactors(meatTitleWithoutSpecial, 'æ', 'ae');
              bytes += utf8.encode(
                  '${meatEle.amount}x ${e.id} + $meatTitleWithoutSpecial\n');
            }
          });
        }
        if (totalMeat < e.amount) {
          bytes += utf8.encode('${e.amount}x ${e.id}\n');
        }
      } else
        bytes += utf8.encode('${e.amount}x - $orderTitleWithoutSpecial\n');
      // if (e.meatChoice != null) {
      //   //   bytes += doubleWide.codeUnits;
      //   // bytes += doubleHeight.codeUnits;
      //   e.meatChoice.forEach((m) {
      //     if (m.amount != 0) {
      //       String meatTitleWithoutSpecial;
      //       meatTitleWithoutSpecial = sortSpecialCharactors(m.title, 'ø', 'oe');
      //       meatTitleWithoutSpecial =
      //           sortSpecialCharactors(meatTitleWithoutSpecial, 'æ', 'ae');
      //       bytes +=
      //           utf8.encode(' ↳-> ${m.amount} med $meatTitleWithoutSpecial\n');
      //     }
      //   });
      // }
      // bytes += doubleWide.codeUnits;
      // bytes += doubleHeight.codeUnits;
      // bytes += utf8.encode('_____________________\n');
      bytes += utf8.encode('\n');
    });
    // bytes += whiteOnBlack.codeUnits;
    bytes += utf8.encode(
        'Total pris: ${CalculateValues.totalPriceFromOrder(order.menuOrder)} kr,-\n');
    // bytes += noWhiteOnBlack.codeUnits;
    // bytes += utf8.encode('_____________________\n');
    bytes += utf8.encode('\n');
    //bytes += reset.codeUnits;
    // bytes += doubleWide.codeUnits;
    // bytes += doubleHeight.codeUnits;

    if (order.orderMessage != 'Ingen kommentar til restaurenten.') {
      String messageWithoutSpecial = '';

      messageWithoutSpecial =
          sortSpecialCharactors(order.orderMessage, 'å', 'aa');
      messageWithoutSpecial =
          sortSpecialCharactors(messageWithoutSpecial, 'æ', 'ae');
      messageWithoutSpecial =
          sortSpecialCharactors(messageWithoutSpecial, 'ø', 'oe');
      messageWithoutSpecial =
          sortSpecialCharactors(messageWithoutSpecial, 'Å', 'Aa');
      messageWithoutSpecial =
          sortSpecialCharactors(messageWithoutSpecial, 'Æ', 'Ae');
      messageWithoutSpecial =
          sortSpecialCharactors(messageWithoutSpecial, 'Ø', 'Oe');

      List<String> messageList = messageWithoutSpecial.split(' ');
      String messageWithBreak = '';
      String tempMessage = '';
      messageList.forEach((element) {
        if (element.contains('\n')) tempMessage = '';
        if ((tempMessage.length + element.length) > 24) {
          messageWithBreak += '\n';
          tempMessage = '';
        }
        tempMessage += '$element ';
        messageWithBreak += '$element ';
      });
      bytes += utf8.encode('$messageWithBreak');

      print(messageWithBreak);
    } else {
      print('Ingen besked');
    }

    bytes += cutPaper.codeUnits;

    //print(utf8.decode(bytes));
    //printerIP = '192.168.1';
    printTicket(bytes, context, checkForPrinters);
  }

  static String sortSpecialCharactors(
      String message, String char, String replaceChar) {
    String newMessage = '';
    List<String> messageList = message.split(char);
    String lastString = messageList.last;
    messageList.removeLast();
    messageList.forEach((element) {
      element += replaceChar;
      newMessage += element;
    });
    newMessage += lastString;
    return newMessage;
  }

  static printTicket(
      List<int> bytes, BuildContext context, bool checkForPrinters) async {
    printerIP = await _loadPrinterIP();
    Duration timeout = const Duration(seconds: 5);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: timeout,

      content: Container(
          width: 40,
          height: 40,
          child: Center(child: CircularProgressIndicator())),
    ));
    var result = await Socket.connect(printerIP, 9100, timeout: timeout)
        .then((Socket socket) {
      socket.add(bytes);
      socket.destroy();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Printer ordren...'),
      ));
      return 'Data sent to printer was successful';
    }).catchError((dynamic e) {
      if (checkForPrinters) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Kunne ikke forbinde til printeren. Vær sikker på at den er tændt og klar.  -  Printer IP: $printerIP.'),
        ));
      }
      // if (checkForPrinters) showSelectPrinterDialog(context);
      return 'Error - Sending data to printer failed: ${e.toString()}';
    });
    print(result);
  }

  // static showSelectPrinterDialog(BuildContext context) {
  //   bool firstTime = true;
  //   showDialog(
  //       context: context,
  //       builder: (_) => new AlertDialog(
  //             title: new Text("Select Printer IP"),
  //             content: Container(
  //               width: 300,
  //               height: 300,
  //               child:
  //                   StatefulBuilder(builder: (BuildContext context, setState) {
  //                 if (firstTime) {
  //                   Future.delayed(Duration.zero, () {
  //                     setState(() {
  //                       isLoadingPrinterIP = true;
  //                     });
  //                     addresses.clear();

  //                     //TODO use the correct ip.
  //                     final stream =
  //                         NetworkAnalyzer.discover2('192.168.1', 9100);
  //                     stream.listen((NetworkAddress addr) {
  //                       if (addr.exists) {
  //                         // setState(() {
  //                         addresses.add(addr);
  //                         // });
  //                       }
  //                       // print('Found device: ${addr.ip}');
  //                     }).onDone(() {
  //                       setState(() {
  //                         isLoadingPrinterIP = false;
  //                       });
  //                     });
  //                   });
  //                   firstTime = false;
  //                 }

  //                 return !isLoadingPrinterIP
  //                     ? addresses.length > 0
  //                         ? ListView.separated(
  //                             separatorBuilder: (context, index) {
  //                               return Divider();
  //                             },
  //                             itemCount: addresses.length,
  //                             itemBuilder: (BuildContext context, int i) {
  //                               return ListTile(
  //                                   leading: Icon(Icons.wifi),
  //                                   title: Text(addresses[i].ip),
  //                                   onTap: () {
  //                                     printerIP = addresses[i].ip;
  //                                     savePrinterIP(printerIP);
  //                                     Navigator.of(context).pop();
  //                                   });
  //                             },
  //                             shrinkWrap: true,
  //                             physics: NeverScrollableScrollPhysics(),
  //                           )
  //                         : Center(
  //                             child: Text('Ingen printere fundet på netværk.'))
  //                     : Center(child: CircularProgressIndicator());
  //               }),
  //             ),
  //             actions: [
  //               FlatButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text('Luk'))
  //             ],
  //           ));
  // }

  static Future<void> savePrinterIP(String printerIP) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setString('printerIP', printerIP);
  }

  static Future<String> _loadPrinterIP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('printerIP') ?? '');
  }
}
