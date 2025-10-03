class Food {
  final int id;
  final String name;
  final String image;
  final int stock;
  final String category;

  Food({
    required this.id,
    required this.name,
    required this.image,
    required this.stock,
    required this.category,
  });



}

  List<Food> myFood = [
  Food(
    id: 1,
    name: "Roti",
    image: "assets/img/roti.png",
    stock: 5,
    category: "Snack",
  ),
  Food(
    id: 2,
    name: "Milk",
    image: "assets/img/drinks.png",
    stock: 7,
    category: "Drink",
  ),
  Food(
    id: 3,
    name: "Maggi",
    image: "assets/img/maggie.png",
    stock: 10,
    category: "Meals",
  ),
  Food(
    id: 4,
    name: "Milo Sachet",
    image: "assets/img/sachet.png",
    stock: 8,
    category: "Sachet",
  ),
  Food(
    id: 5,
    name: "Corn Bun",
    image: "assets/img/roti.png",
    stock: 6,
    category: "Snack",
  ),
];
