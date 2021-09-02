

import 'CategoryCard.dart';
import 'MenuItem.dart';

class MealsLog {
  static int pageIndex = 0;

  static int totalPrice = 0;
  //TODO change to amount of meal lists
  static List<CategoryCard> menuCategoryCards = [
    // CategoryCard('SANDWICHES', 'Vores sandwiches serveres med tomat, agurk, salat og peberfrugt.', false),
    // CategoryCard('SALATER', 'Serveres med brød.', false),
    // CategoryCard('OMELETTER', 'Serveres med brød og smør.', false),
    // CategoryCard('PASTA RETTER', '', false),
    // CategoryCard('ALLA CARTE', 'Alle kødretter serveres med dagens garniture.', false),
    // CategoryCard('PIZZA', 'Original pizzadej med olivenolie. Alle pizzaer er med tomat og ost.', false),
    // CategoryCard('SPECIALITETER', '', false),
    // CategoryCard('ZUPPA/SUPPE', '', false),
    // CategoryCard('BØRNE MENU', '', false),
    // CategoryCard('DESSERTER', '', false),
    // CategoryCard('KOLDE DRIKKE', '', false),
    // CategoryCard('VARME DRIKKE', '', false),
  ];

  //TODO = DONE? ChangeTo final Static lists

  static List<List<MenuItem>> allMenus = [
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


// //OMELETTER
//     [
//       MenuItem(10, 'KYLLING OG BACON', 'Med kylling og bacon og cheddarost', 85, '', 0, meatChoice: []),
//       MenuItem(11, 'VEGETAR OMELET', 'Med grillede grøntsager, champignon og cheddarost', 85, '', 0, meatChoice: []),
//       MenuItem(12, 'HUSETS OMELET', 'Med løg, bacon, cherry tomater, olivenolie og cheddarost', 85, 'assets/ilmolino/menu/12.jpg', 0, meatChoice: []),
//     ],

// //PASTA RETTER
//     [
//       MenuItem(13, 'LASAGNE', 'Med kødsauce', 89, '', 0, meatChoice: []),
//       MenuItem(14, 'SPAGHETTI BOLOGNESE', 'Spaghetti med kødsauce', 89, 'assets/ilmolino/menu/14.jpg', 0, meatChoice: []),
//       MenuItem(15, 'SPAGHETTI ALLA CARBONARE', 'Med bacon, æg, flødesauce og frisk parmesan', 89, '', 0, meatChoice: []),
//       MenuItem(16, 'PASTA PESTO', 'Penne med kylling, hjemmelavet pesto og frisk grana', 89, 'assets/ilmolino/menu/16.jpg', 0, meatChoice: []),
//       MenuItem(17, 'SPAGHETTI CON CARNE', 'Med bøfstrimler, løg, champignon, pomodore og frisk grana', 95, '', 0, meatChoice: []),
//       MenuItem(18, 'SPAGHETTI ALLA GORGONZOLA', 'Med gorgonzola, serano og frisk grana', 95, '', 0, meatChoice: []),
//       MenuItem(19, 'PENNE ALLA LAKS', 'Med røget laks og pomodore, pesto og frisk grana', 95, '', 0, meatChoice: []),
//       MenuItem(20, 'TORTELLINI PANNA PROSCIUTTO', 'Med skinke, løg, champignon, pomodore og ost', 95, '', 0, meatChoice: []),
//       MenuItem(21, 'PENNE VEGETALI', 'Med grillede grøntsager, løg, champignon, pomodore og frisk grana', 95, '', 0, meatChoice: []),
//     ],

//     //ALLA CARTE
//     [
//       MenuItem(22, 'BØF CLASSICA', 'Mør og saftig oksefilet med bearnaisesauce og italiensk rosmarin kartofler', 159, '', 0, meatChoice: []),
//       MenuItem(23, 'HVIDLØGS BØF', 'Mør og lækker oksefilet marineret med hvidløg, creme fraiche og kartofler', 159, '', 0, meatChoice: []),
//       MenuItem(24, 'HUSETS BØF', 'Mør og saftig oksefilet med hjemmelavet whisky sauce og italienske rosmarin kartofler', 169, '', 0, meatChoice: []),
//       MenuItem(25, 'TARTUFO', 'Mør og saftig oksefilet med hjemmelavet trøffel sauce og italienske rosmarin kartofler', 169, '', 0, meatChoice: []),
//     ],

//     //PIZZA
//     [
//       MenuItem(30, 'MARGHERITA', 'Tomat og ost', 65, '', 0, meatChoice: []),
//       MenuItem(31, 'CAPRICCIOSA', 'Skinke og champignon', 75, '', 0, meatChoice: []),
//       MenuItem(32, 'CACCIATORE', 'Pepperoni, oliven og friske tomater', 75, '', 0, meatChoice: []),
//       MenuItem(33, 'CALZONE (INDBAGT)', 'Med skinke og champignon', 75, '', 0, meatChoice: []),
//       MenuItem(34, 'HAWAII', 'Skinke og ananas', 75, '', 0, meatChoice: []),
//       MenuItem(35, 'NAPOLI', 'Ansjoser, oliven, løg, kapers og hvidløg', 85, '', 0, meatChoice: []),
//       MenuItem(36, 'POLO', 'Med kylling, frisk tomat og rucola', 85, '', 0, meatChoice: []),
//       MenuItem(37, 'ESTATE', 'Med serano , rucola, frisk grana og pesto', 85, '', 0, meatChoice: []),
//       MenuItem(38, 'PEPINO', 'Med italiensk salami, rucola, frisk grana og pesto', 85, '', 0, meatChoice: []),
//       MenuItem(39, 'PERIMAVERA', 'Med frisk mozzarella, frisk tomat, basilicum og pesto', 85, '', 0, meatChoice: []),
//       MenuItem(40, 'PARMA', 'Med gorgonzola, champignon og serano', 85, '', 0, meatChoice: []),
//       MenuItem(41, 'MONZESE', 'Med spinat, gorgonzola, grana, chili og hvidløg', 85, '', 0, meatChoice: []),
//       MenuItem(42, 'SPINACI', 'Med røget laks, spinat, rejer og hvidløg', 89, '', 0, meatChoice: []),
//       MenuItem(43, 'PATATA', 'Med kartofler, frisk mozzarella, frisk rosmarin og oliven', 89, 'assets/ilmolino/menu/43.jpg', 0, meatChoice: []),
//       MenuItem(44, 'CONTADINA', 'Med frisk mozzarella, kylling, stegt bacon og spinat', 89, '', 0, meatChoice: []),
//       MenuItem(45, 'MONDENA', 'Med frisk mozzarella, rucola, cherry tomater og frisk grana', 89, 'assets/ilmolino/menu/45.jpg', 0, meatChoice: []),
//       MenuItem(46, 'HUSETS SPECIAL', 'Med italiensk bøfstrimler, løg, peberfrugt, champignon og sød sennep', 89, '', 0, meatChoice: []),
//       MenuItem(47, 'SICILIA', 'Med frisk avokado, luksus bacon og cherry tomater m/u pesto', 89, 'assets/ilmolino/menu/47.jpg', 0, meatChoice: []),
//       MenuItem(48, 'DELLA CASA', 'Oksekød, bacon, tomater, løg, peberfrugt og kapers', 89, '', 0, meatChoice: []),
//     ],

//     //SPECIALITETER
//     [
//       MenuItem(50, 'CAFE BURGER', '200 gram hakkebøf med cheddarost i økologisk bolle og italiensk rosmarin kartofler', 119,
//           'assets/ilmolino/menu/50.jpg', 0,
//           meatChoice: []),
//       MenuItem(51, 'CHILLI CON CARNE', 'Tilberedt med hjemmelavet salsa, nachos, brød og creme fraiche', 109, 'assets/ilmolino/menu/51.jpg', 0,
//           meatChoice: []),
//       MenuItem(52, 'BURRITO', 'Ovnbagte meltortillas med bønner, oksekød, tortilla chips og salat', 109, '', 0, meatChoice: []),
//       MenuItem(53, 'NACHOS', 'Tortila chips med kylling, ost og salsa eller guacamole', 89, '', 0, meatChoice: []),
//     ],

//     //ZUPPA/SUPPE
//     [
//       MenuItem(60, 'CREMA DI POMODORO', 'Tomat suppe med brød', 59, '', 0, meatChoice: []),
//       MenuItem(61, 'ZUPPA DI VERDURE', 'Grøntsags suppe med brød', 59, '', 0, meatChoice: []),
//     ],

//     //BØRNE MENU
//     [
//       MenuItem(62, 'SPAGHETTI BOLOGNESE', 'Spaghetti med kødsauce', 59, '', 0, meatChoice: []),
//       MenuItem(63, 'PIZZA BAMBINO', 'Med tomat, ost, skinke og pølser', 59, '', 0, meatChoice: []),
//       MenuItem(64, 'LASAGNE BAMBINO', 'Lasagne med kødsauce', 59, '', 0, meatChoice: []),
//     ],

//     //DESSERTER
//     [
//       MenuItem(70, 'CRESPELE CON GELATO', 'Pandekage med italiensk is og chokoladesauce', 59, '', 0, meatChoice: []),
//       MenuItem(71, 'GELATO DELLA CASA', 'Husets is med chokolade sauce', 59, '', 0, meatChoice: []),
//       MenuItem(72, 'TORTA VARM DRIK', 'Med italiensk kage', 59, '', 0, meatChoice: []),
//       MenuItem(73, 'DESSERT PIZZA', '', 75, '', 0, meatChoice: []),
//     ],

//     //KOLDE DRIKKE
//     [
//       MenuItem(90, 'Cola, Cola Zero, Sprite, Fanta', '', 27, '', 0, meatChoice: []),
//       MenuItem(91, 'Økologisk hyldeblomst eller solbær', '', 29, '', 0, meatChoice: []),
//       MenuItem(92, 'San Pellegrino med brus 0, meatChoice: []5 l.', '', 35, '', 0, meatChoice: []),
//       MenuItem(93, 'Limonade 0, meatChoice: []5 l.', '', 35, '', 0, meatChoice: []),
//       MenuItem(94, 'Aranciate Rossa (blodappelsin) 0, meatChoice: []5 l.', '', 35, '', 0, meatChoice: []),
//       MenuItem(95, 'Italiensk øl (Peroni)', '', 35, '', 0, meatChoice: []),
//       MenuItem(96, 'Tuborg profil', '', 30, '', 0, meatChoice: []),
//       MenuItem(97, 'La Rossa Moretti', '', 29, '', 0, meatChoice: []),
//       MenuItem(98, 'Italiensk kildevand,-', '', 22, '', 0, meatChoice: []),
//     ],

//     //VARME DRIKKE
//     [
//       MenuItem(100, 'Kaffe', '', 24, '', 0, meatChoice: []),
//       MenuItem(101, 'Espresso', '', 24, '', 0, meatChoice: []),
//       MenuItem(102, 'Dobbelt espresso', '', 32, '', 0, meatChoice: []),
//       MenuItem(103, 'Cappuccino', '', 30, '', 0, meatChoice: []),
//       MenuItem(104, 'Caffe latte', '', 35, '', 0, meatChoice: []),
//       MenuItem(105, 'Café au lait', '', 35, '', 0, meatChoice: []),
//       MenuItem(106, 'Chai latte', '', 35, '', 0, meatChoice: []),
//     ],
  ];
}