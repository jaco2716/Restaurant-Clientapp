class MeatChoice {
  int id;
  String title;
  int price;
  int amount;

  MeatChoice(this.id, this.title, this.price, this.amount);

  @override
  bool operator ==(other) {
    return (other is MeatChoice) && other.id == id && other.title == title && other.price == price;
  }

  MeatChoice.clone(MeatChoice meatChoiceCopy) : this(meatChoiceCopy.id, meatChoiceCopy.title, meatChoiceCopy.price, meatChoiceCopy.amount);

  MeatChoice.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        amount = json['amount'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'amount': amount,
      };
}
