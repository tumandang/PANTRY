class Category {

  final String name , image;

  Category({ // constructor thank you khir rahman
    required this.image,
    required this.name
  });




}
  List <Category> myCategory = [
    Category(name: "All", image: "assets/img/unipantry_logo.png"),
    Category(image: 'assets/img/maggie.png', name: 'Meals'),
    Category(image: 'assets/img/drinks.png', name: 'Drink'),
    Category(image: 'assets/img/snack.png', name: 'Snack'),
    Category(image: 'assets/img/sachet.png', name: 'Sachet'),
  ];