import 'package:PANTRY/models/cartitem.dart';
import 'package:flutter/material.dart';

class Cartmanager extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  //tambah barang

  void additem(CartItem item) {
    final check = _items.indexWhere((i) => i.id == item.id);

    if (check != -1) {
      _items[check] = CartItem(
        id: _items[check].id,
        name: _items[check].name,
        category: _items[check].category,
        quantity: _items[check].quantity + 1,
        stock: _items[check].stock,
        imageUrl: _items[check].imageUrl,
      );
    }
    else{
      _items.add(item);
    }
    notifyListeners();
  }


  //buang

  void removeItem(int id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  //kurangkan

  void updateQuantity(int id, int newQuantity) {
  final index = _items.indexWhere((item) => item.id == id);
  if (index != -1) {
    if (newQuantity <= 0) {
      // auto remove if quantity <= 0
      _items.removeAt(index);
    } else {
      _items[index] = CartItem(
        id: _items[index].id,
        name: _items[index].name,
        category: _items[index].category,
        quantity: newQuantity,
        stock: _items[index].stock,
        imageUrl: _items[index].imageUrl,
      );
    }
    notifyListeners();
  }
}

  // Clear 
  void clear() {
    _items.clear();
    notifyListeners();
  }

   int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
}
