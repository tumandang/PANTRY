class Food {
  final int id;
  final String name;
  final String image;
  final int quantity;
  final String category;


  Food({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.category,

  });


  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      quantity: int.parse(json['quantity'].toString()),
      category: json['category'],
      image: json['image'],
    );
  }
}

