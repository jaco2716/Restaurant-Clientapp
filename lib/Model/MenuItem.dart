import 'MeatChoice.dart';

class MenuItem {
  int id;
  String title;
  String description;
  int price;
  String image;
  int amount;
  List<MeatChoice> meatChoice;

  MenuItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.amount,
    required this.meatChoice,
  });

  @override
  bool operator ==(other) {
    return (other is MenuItem) &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price;
  }

  MenuItem.clone(MenuItem menuItemCopy)
      : this(
            id: menuItemCopy.id,
            title: menuItemCopy.title,
            description: menuItemCopy.description,
            price: menuItemCopy.price,
            image: menuItemCopy.image,
            amount: menuItemCopy.amount,
            meatChoice: menuItemCopy.meatChoice);

  MenuItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        image = json['image'],
        amount = json['amount'],
        meatChoice = (json['meatChoice'] as List).map((e) => MeatChoice.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'image': image,
        'amount': amount,
        'meatChoice': meatChoice.map((e) => e.toJson()).toList(),
        //'meatChoice': jsonEncode(meatChoice),
      };

  @override
  String toString() {
    return "$id, $title, $price dk,- Antal: $amount. extra";
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode ^ price.hashCode ^ meatChoice.hashCode;
}
