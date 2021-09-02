class Accessories {
    int id;
    String title;
    String description;
    int price;
    int amount;

    Accessories(this.id, this.title, this.description, this.price, this.amount);

    @override
    String toString() {
    return "$id, $title, $price dk,- Antal: $amount.";
     }
}