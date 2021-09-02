class FcmNotification {
  String id;
  String title;
  String description;

  FcmNotification({
    required this.id,
    required this.title,
    required this.description,
  });

  FcmNotification.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] ?? '',
        description = json['description'] ?? '';

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'title': title,
  //       'description': description,
  //       'price': price,
  //       'image': image,
  //       'amount': amount,
  //     };
}
