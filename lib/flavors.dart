import 'package:flutter/material.dart';
import 'Model/MeatChoice.dart';
import 'Model/CategoryCard.dart';
import 'Model/MenuItem.dart';

enum Flavor {
  ilmolino,
  orderappTest,
}

class F {
  static Flavor? appFlavor;
  static String get appTitle {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'IL MOLINO';
      case Flavor.orderappTest:
        return 'Orderapptest';
      default:
        return 'title';
    }
  }
  static Map<String, dynamic> get adminUser {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return {'email': 'ilmolino@admin.dk', 'password': 'admin201295'};
      case Flavor.orderappTest:
        return {'email': 'orderapptesto@admin.dk', 'password': 'admin201295'};
      default:
        return {'email': 'orderapptesto@admin.dk', 'password': 'admin201295'};
    }
  }

  static String get companyWebsite {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'https://ilmolinolyngby.dk';
      case Flavor.orderappTest:
        return 'https://orderapptest.dk';
      default:
        return 'companyWebsite';
    }
  }

  static String get companyPhone {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return '+45 45 88 51 10';
      case Flavor.orderappTest:
        return '+45 12 34 56 78';
      default:
        return 'companyPhone';
    }
  }

  static String get companyAddress {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'Gammel Lundtoftevej 14, 2800 Kongens Lyngby';
      case Flavor.orderappTest:
        return 'test addresse og noget mere';
      default:
        return 'companyAddress';
    }
  }

  static String get privacyPolicyURL {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'https://www.termsfeed.com/live/yourPolicy';
      case Flavor.orderappTest:
        return 'https://www.termsfeed.com/live/yourPolicy';
      default:
        return 'privacyPolicyURL';
    }
  }

  static MaterialColor get appPrimaryColor {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return Colors.brown;
      case Flavor.orderappTest:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  static MaterialColor get appSecondaryColor {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return Colors.yellow;
      case Flavor.orderappTest:
        return Colors.lightGreen;
      default:
        return Colors.lightBlue;
    }
  }

  static String get appIconPathLight {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'assets/ilmolino/icons/iconlight.png';
      case Flavor.orderappTest:
        return 'assets/orderapptest/icons/iconlight.png';
      default:
        return '';
    }
  }

  static String get appIconPathDark {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'assets/ilmolino/icons/icondark.png';
      case Flavor.orderappTest:
        return 'assets/orderapptest/icons/icondark.png';
      default:
        return '';
    }
  }

  static String get firestoreCollection {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'application/ilmolino';
      case Flavor.orderappTest:
        return 'application/orderapptest';
      default:
        return 'testing/';
    }
  }

  static String get baseURL {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'https://fcm.googleapis.com';
      case Flavor.orderappTest:
        return 'https://fcm.googleapis.com';
      default:
        return 'https://fcm.googleapis.com';
    }
  }

  static String get serverToken {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return '';
      case Flavor.orderappTest:
        return '';
      default:
        return '';
    }
  }

  static List<List<MenuItem>> get allMenus {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return [
          //SANDWICHES
          [
            MenuItem(id: 1, title: 'CLUB SANDWICH', description: 'Med kylling, bacon og pesto', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 2,
                title: 'Serano SANDWICH',
                description: 'Med frisk mozzarella eller gorgonzola, serano og pesto',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 3,
                title: 'LAKSE SANDWICH',
                description: 'Med røget laks og hjemmelavet dilddressing',
                price: 75,
                image: 'assets/ilmolino/menu/3.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 4,
                title: 'BACON AVOKADO',
                description: 'Med luksus bacon, frisk avokado og pesto',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 5,
                title: 'TUNO',
                description: 'Med hjemmelavet tunmousse og pesto',
                price: 75,
                image: 'assets/ilmolino/menu/5.jpg',
                amount: 0,
                meatChoice: []),
          ],

//SALATER
          [
            MenuItem(
                id: 6,
                title: 'INSALATA CAPRESE',
                description: 'Med frisk mozzarella, frisk basilikum, stilk tomat og hjemmelavet pesto',
                price: 89,
                image: 'assets/ilmolino/menu/6.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 7,
                title: 'KYLLING & BACON',
                description: 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 8,
                title: 'HJEMMELAVET TUNCREME',
                description: 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto',
                price: 89,
                image: 'assets/ilmolino/menu/8.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 9,
                title: 'KYLLING PASTA SALAT',
                description: 'Serveres med penne, peberfrugt, semi-dried tomater, rucola, oliven og pesto',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

//OMELETTER
          [
            MenuItem(
                id: 10,
                title: 'KYLLING OG BACON',
                description: 'Med kylling og bacon og cheddarost',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 11,
                title: 'VEGETAR OMELET',
                description: 'Med grillede grøntsager, champignon og cheddarost',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 12,
                title: 'HUSETS OMELET',
                description: 'Med løg, bacon, cherry tomater, olivenolie og cheddarost',
                price: 85,
                image: 'assets/ilmolino/menu/12.jpg',
                amount: 0,
                meatChoice: []),
          ],

//PASTA RETTER
          [
            MenuItem(id: 13, title: 'LASAGNE', description: 'Med kødsauce', price: 89, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 14,
                title: 'SPAGHETTI BOLOGNESE',
                description: 'Spaghetti med kødsauce',
                price: 89,
                image: 'assets/ilmolino/menu/14.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 15,
                title: 'SPAGHETTI ALLA CARBONARE',
                description: 'Med bacon, æg, flødesauce og frisk parmesan',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 16,
                title: 'PASTA PESTO',
                description: 'Penne med kylling, hjemmelavet pesto og frisk grana',
                price: 89,
                image: 'assets/ilmolino/menu/16.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 17,
                title: 'SPAGHETTI CON CARNE',
                description: 'Med bøfstrimler, løg, champignon, pomodore og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 18,
                title: 'SPAGHETTI ALLA GORGONZOLA',
                description: 'Med gorgonzola, serano og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 19,
                title: 'PENNE ALLA LAKS',
                description: 'Med røget laks og pomodore, pesto og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 20,
                title: 'TORTELLINI PANNA PROSCIUTTO',
                description: 'Med skinke, løg, champignon, pomodore og ost',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 21,
                title: 'PENNE VEGETALI',
                description: 'Med grillede grøntsager, løg, champignon, pomodore og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //ALLA CARTE
          [
            MenuItem(
                id: 22,
                title: 'BØF CLASSICA',
                description: 'Mør og saftig oksefilet med bearnaisesauce og italiensk rosmarin kartofler',
                price: 159,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 23,
                title: 'HVIDLØGS BØF',
                description: 'Mør og lækker oksefilet marineret med hvidløg, creme fraiche og kartofler',
                price: 159,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 24,
                title: 'HUSETS BØF',
                description: 'Mør og saftig oksefilet med hjemmelavet whisky sauce og italienske rosmarin kartofler',
                price: 169,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 25,
                title: 'TARTUFO',
                description: 'Mør og saftig oksefilet med hjemmelavet trøffel sauce og italienske rosmarin kartofler',
                price: 169,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //PIZZA
          [
            MenuItem(id: 30, title: 'MARGHERITA', description: 'Tomat og ost', price: 65, image: '', amount: 0, meatChoice: [
              MeatChoice(1, 'Oliven', 5, 0),
              MeatChoice(2, 'Salat', 5, 0),
              MeatChoice(3, 'Pesto', 5, 0),
              MeatChoice(4, 'Agurk', 5, 0),
              MeatChoice(5, 'Chilli', 5, 0),
              MeatChoice(6, 'Salt', 5, 0),
              MeatChoice(7, 'Peber', 5, 0),
              MeatChoice(8, 'Paprika', 5, 0),
              MeatChoice(9, 'Hvidløg', 5, 0),
              MeatChoice(10, 'Løg', 5, 0),
            ]),
            MenuItem(id: 31, title: 'CAPRICCIOSA', description: 'Skinke og champignon', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 32, title: 'CACCIATORE', description: 'Pepperoni, oliven og friske tomater', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 33, title: 'CALZONE (INDBAGT)', description: 'Med skinke og champignon', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 34, title: 'HAWAII', description: 'Skinke og ananas', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 35, title: 'NAPOLI', description: 'Ansjoser, oliven, løg, kapers og hvidløg', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 36, title: 'POLO', description: 'Med kylling, frisk tomat og rucola', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 37, title: 'ESTATE', description: 'Med serano , rucola, frisk grana og pesto', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 38,
                title: 'PEPINO',
                description: 'Med italiensk salami, rucola, frisk grana og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 39,
                title: 'PERIMAVERA',
                description: 'Med frisk mozzarella, frisk tomat, basilicum og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 40, title: 'PARMA', description: 'Med gorgonzola, champignon og serano', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 41,
                title: 'MONZESE',
                description: 'Med spinat, gorgonzola, grana, chili og hvidløg',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 42, title: 'SPINACI', description: 'Med røget laks, spinat, rejer og hvidløg', price: 89, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 43,
                title: 'PATATA',
                description: 'Med kartofler, frisk mozzarella, frisk rosmarin og oliven',
                price: 89,
                image: 'assets/ilmolino/menu/43.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 44,
                title: 'CONTADINA',
                description: 'Med frisk mozzarella, kylling, stegt bacon og spinat',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 45,
                title: 'MONDENA',
                description: 'Med frisk mozzarella, rucola, cherry tomater og frisk grana',
                price: 89,
                image: 'assets/ilmolino/menu/45.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 46,
                title: 'HUSETS SPECIAL',
                description: 'Med italiensk bøfstrimler, løg, peberfrugt, champignon og sød sennep',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 47,
                title: 'SICILIA',
                description: 'Med frisk avokado, luksus bacon og cherry tomater m/u pesto',
                price: 89,
                image: 'assets/ilmolino/menu/47.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 48,
                title: 'DELLA CASA',
                description: 'Oksekød, bacon, tomater, løg, peberfrugt og kapers',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //SPECIALITETER
          [
            MenuItem(
                id: 50,
                title: 'CAFE BURGER',
                description: '200 gram hakkebøf med cheddarost i økologisk bolle og italiensk rosmarin kartofler',
                price: 119,
                image: 'assets/ilmolino/menu/50.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 51,
                title: 'CHILLI CON CARNE',
                description: 'Tilberedt med hjemmelavet salsa, nachos, brød og creme fraiche',
                price: 109,
                image: 'assets/ilmolino/menu/51.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 52,
                title: 'BURRITO',
                description: 'Ovnbagte meltortillas med bønner, oksekød, tortilla chips og salat',
                price: 109,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 53,
                title: 'NACHOS',
                description: 'Tortila chips med kylling, ost og salsa eller guacamole',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //ZUPPA/SUPPE
          [
            MenuItem(id: 60, title: 'CREMA DI POMODORO', description: 'Tomat suppe med brød', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 61, title: 'ZUPPA DI VERDURE', description: 'Grøntsags suppe med brød', price: 59, image: '', amount: 0, meatChoice: []),
          ],

          //BØRNE MENU
          [
            MenuItem(id: 62, title: 'SPAGHETTI BOLOGNESE', description: 'Spaghetti med kødsauce', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 63, title: 'PIZZA BAMBINO', description: 'Med tomat, ost, skinke og pølser', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 64, title: 'LASAGNE BAMBINO', description: 'Lasagne med kødsauce', price: 59, image: '', amount: 0, meatChoice: []),
          ],

          //DESSERTER
          [
            MenuItem(
                id: 70,
                title: 'CRESPELE CON GELATO',
                description: 'Pandekage med italiensk is og chokoladesauce',
                price: 59,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 71, title: 'GELATO DELLA CASA', description: 'Husets is med chokolade sauce', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 72, title: 'TORTA VARM DRIK', description: 'Med italiensk kage', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 73, title: 'DESSERT PIZZA', description: '', price: 75, image: '', amount: 0, meatChoice: []),
          ],

          //KOLDE DRIKKE
          [
            MenuItem(id: 90, title: 'Cola, Cola Zero, Sprite, Fanta', description: '', price: 27, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 91, title: 'Økologisk hyldeblomst eller solbær', description: '', price: 29, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 92, title: 'San Pellegrino med brus', description: '0,5 l.', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 93, title: 'Limonade', description: '0,5 l.', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 94, title: 'Aranciate Rossa', description: 'Blodappelsin 0,5 l.', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 95, title: 'Italiensk øl', description: 'Peroni', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 96, title: 'Tuborg profil', description: '', price: 30, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 97, title: 'La Rossa Moretti', description: '', price: 29, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 98, title: 'Italiensk kildevand', description: '', price: 22, image: '', amount: 0, meatChoice: []),
          ],

          //VARME DRIKKE
          [
            MenuItem(id: 100, title: 'Kaffe', description: '', price: 24, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 101, title: 'Espresso', description: '', price: 24, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 102, title: 'Dobbelt espresso', description: '', price: 32, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 103, title: 'Cappuccino', description: '', price: 30, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 104, title: 'Caffe latte', description: '', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 105, title: 'Café au lait', description: '', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 106, title: 'Chai latte', description: '', price: 35, image: '', amount: 0, meatChoice: []),
          ],
        ];
      case Flavor.orderappTest:
        return [
          //SANDWICHES
          [
            MenuItem(id: 1, title: 'CLUB SANDWICH Test', description: 'Med kylling, bacon og pesto', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 2,
                title: 'Serano SANDWICH Test',
                description: 'Med frisk mozzarella eller gorgonzola, serano og pesto',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 3,
                title: 'LAKSE SANDWICH Test',
                description: 'Med røget laks og hjemmelavet dilddressing',
                price: 75,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 4,
                title: 'BACON AVOKADO Test',
                description: 'Med luksus bacon, frisk avokado og pesto',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 5,
                title: 'TUNO Test',
                description: 'Med hjemmelavet tunmousse og pesto',
                price: 75,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
          ],

//SALATER
          [
            MenuItem(
                id: 6,
                title: 'INSALATA CAPRESE Test',
                description: 'Med frisk mozzarella, frisk basilikum, stilk tomat og hjemmelavet pesto',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 7,
                title: 'KYLLING & BACON Test',
                description: 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 8,
                title: 'HJEMMELAVET TUNCREME Test',
                description: 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 9,
                title: 'KYLLING PASTA SALAT Test',
                description: 'Serveres med penne, peberfrugt, semi-dried tomater, rucola, oliven og pesto',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

//OMELETTER
          [
            MenuItem(
                id: 10,
                title: 'KYLLING OG BACON Test',
                description: 'Med kylling og bacon og cheddarost',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 11,
                title: 'VEGETAR OMELET Test',
                description: 'Med grillede grøntsager, champignon og cheddarost',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 12,
                title: 'HUSETS OMELET Test',
                description: 'Med løg, bacon, cherry tomater, olivenolie og cheddarost',
                price: 85,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
          ],

//PASTA RETTER
          [
            MenuItem(id: 13, title: 'LASAGNE Test', description: 'Med kødsauce', price: 89, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 14,
                title: 'SPAGHETTI BOLOGNESE Test',
                description: 'Spaghetti med kødsauce',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 15,
                title: 'SPAGHETTI ALLA CARBONARE Test',
                description: 'Med bacon, æg, flødesauce og frisk parmesan',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 16,
                title: 'PASTA PESTO Test',
                description: 'Penne med kylling, hjemmelavet pesto og frisk grana',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 17,
                title: 'SPAGHETTI CON CARNE Test',
                description: 'Med bøfstrimler, løg, champignon, pomodore og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 18,
                title: 'SPAGHETTI ALLA GORGONZOLA Test',
                description: 'Med gorgonzola, serano og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 19,
                title: 'PENNE ALLA LAKS Test',
                description: 'Med røget laks og pomodore, pesto og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 20,
                title: 'TORTELLINI PANNA PROSCIUTTO Test',
                description: 'Med skinke, løg, champignon, pomodore og ost',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 21,
                title: 'PENNE VEGETALI Test',
                description: 'Med grillede grøntsager, løg, champignon, pomodore og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //ALLA CARTE
          [
            MenuItem(
                id: 22,
                title: 'BØF CLASSICA Test',
                description: 'Mør og saftig oksefilet med bearnaisesauce og italiensk rosmarin kartofler',
                price: 159,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 23,
                title: 'HVIDLØGS BØF Test',
                description: 'Mør og lækker oksefilet marineret med hvidløg, creme fraiche og kartofler',
                price: 159,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 24,
                title: 'HUSETS BØF Test',
                description: 'Mør og saftig oksefilet med hjemmelavet whisky sauce og italienske rosmarin kartofler',
                price: 169,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 25,
                title: 'TARTUFO Test',
                description: 'Mør og saftig oksefilet med hjemmelavet trøffel sauce og italienske rosmarin kartofler',
                price: 169,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //PIZZA
          [
            MenuItem(id: 30, title: 'MARGHERITA Test', description: 'Tomat og ost', price: 65, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 31, title: 'CAPRICCIOSA Test', description: 'Skinke og champignon', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 32,
                title: 'CACCIATORE Test',
                description: 'Pepperoni, oliven og friske tomater',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 33, title: 'CALZONE (INDBAGT) Test', description: 'Med skinke og champignon', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 34, title: 'HAWAII Test', description: 'Skinke og ananas', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 35,
                title: 'NAPOLI Test',
                description: 'Ansjoser, oliven, løg, kapers og hvidløg',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 36, title: 'POLO Test', description: 'Med kylling, frisk tomat og rucola', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 37,
                title: 'ESTATE Test',
                description: 'Med serano , rucola, frisk grana og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 38,
                title: 'PEPINO Test',
                description: 'Med italiensk salami, rucola, frisk grana og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 39,
                title: 'PERIMAVERA Test',
                description: 'Med frisk mozzarella, frisk tomat, basilicum og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 40, title: 'PARMA Test', description: 'Med gorgonzola, champignon og serano', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 41,
                title: 'MONZESE Test',
                description: 'Med spinat, gorgonzola, grana, chili og hvidløg',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 42,
                title: 'SPINACI Test',
                description: 'Med røget laks, spinat, rejer og hvidløg',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 43,
                title: 'PATATA Test',
                description: 'Med kartofler, frisk mozzarella, frisk rosmarin og oliven',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 44,
                title: 'CONTADINA Test',
                description: 'Med frisk mozzarella, kylling, stegt bacon og spinat',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 45,
                title: 'MONDENA Test',
                description: 'Med frisk mozzarella, rucola, cherry tomater og frisk grana',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 46,
                title: 'HUSETS SPECIAL Test',
                description: 'Med italiensk bøfstrimler, løg, peberfrugt, champignon og sød sennep',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 47,
                title: 'SICILIA Test',
                description: 'Med frisk avokado, luksus bacon og cherry tomater m/u pesto',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 48,
                title: 'DELLA CASA Test',
                description: 'Oksekød, bacon, tomater, løg, peberfrugt og kapers',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],
        ];
      default:
        return [];
    }
  }

  static List<CategoryCard> get menuCategoryCards {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return [
          CategoryCard('SANDWICHES', 'Vores sandwiches serveres med tomat, agurk, salat og peberfrugt.', false),
          CategoryCard('SALATER', 'Serveres med brød.', false),
          CategoryCard('OMELETTER', 'Serveres med brød og smør.', false),
          CategoryCard('PASTA RETTER', '', false),
          CategoryCard('ALLA CARTE', 'Alle kødretter serveres med dagens garniture.', false),
          CategoryCard('PIZZA', 'Original pizzadej med olivenolie. Alle pizzaer er med tomat og ost.', false),
          CategoryCard('SPECIALITETER', '', false),
          CategoryCard('ZUPPA/SUPPE', '', false),
          CategoryCard('BØRNE MENU', '', false),
          CategoryCard('DESSERTER', '', false),
          CategoryCard('KOLDE DRIKKE', '', false),
          CategoryCard('VARME DRIKKE', '', false),
        ];
      case Flavor.orderappTest:
        return [
          CategoryCard('SANDWICHES Test', 'Vores sandwiches serveres med tomat, agurk, salat og peberfrugt.', false),
          CategoryCard('SALATER Test', 'Serveres med brød.', false),
          CategoryCard('OMELETTER Test', 'Serveres med brød og smør.', false),
          CategoryCard('PASTA RETTER Test', '', false),
          CategoryCard('ALLA CARTE Test', 'Alle kødretter serveres med dagens garniture.', false),
          CategoryCard('PIZZA Test', 'Original pizzadej med olivenolie. Alle pizzaer er med tomat og ost.', false),
        ];
      default:
        return [];
    }
  }
}
