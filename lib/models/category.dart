class Category {

  final String name , image;

  Category({ // constructor thank you khir rahman
    required this.image,
    required this.name
  });




}
  List <Category> myCategory = [
    Category(name: "All Foods", image: "assets/img/unipantry_logo.png"),
    Category(image: 'assets/img/soda.png', name: 'Beverage'),
    Category(image: 'assets/img/noodle.png', name: 'Canned-food'),
    Category(image: 'assets/img/chips.png', name: 'Snacks'),
    Category(image: 'assets/img/bread.jpg', name: 'Fresh-Bread'),
    Category(image: 'assets/img/coffe.jpg', name: '3-in-1-sachet'),
  ];