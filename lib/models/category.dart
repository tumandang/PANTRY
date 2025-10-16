class Category {

  final String name , image;

  Category({ // constructor thank you khir rahman
    required this.image,
    required this.name
  });




}
  List <Category> myCategory = [
    Category(name: "All Foods", image: "assets/img/unipantry_logo.png"),
    Category(image: 'assets/img/drinks.png', name: 'Beverage'),
    Category(image: 'assets/img/maggie.png', name: 'Canned-food'),
    Category(image: 'assets/img/snack.png', name: 'Snacks'),
    Category(image: 'assets/img/roti.png', name: 'Fresh-Bread'),
    Category(image: 'assets/img/sachet.png', name: '3-in-1-sachet'),
  ];