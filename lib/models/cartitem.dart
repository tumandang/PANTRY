class CartItem {
final int id;       
final String name;     
final String category; 
final int quantity;    
final int stock;      
final String imageUrl;

CartItem({
    required this.id,
    required this.name,
    required this.category,
    this.quantity = 1,
    this.stock = 0,
    this.imageUrl = '',
  });

}