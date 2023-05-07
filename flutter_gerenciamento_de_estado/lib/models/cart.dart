import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gerenciamento_de_estado/models/cart_item.dart';
import 'package:flutter_gerenciamento_de_estado/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantidade;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existingItem) => CartItem(
              productId: existingItem.productId,
              id: existingItem.id,
              name: existingItem.name,
              quantidade: existingItem.quantidade + 1,
              price: existingItem.price));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              productId: product.id,
              id: Random().nextDouble.toString(),
              name: product.name,
              quantidade: 1,
              price: product.price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantidade == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItem(
          productId: existingItem.productId,
          id: existingItem.id,
          name: existingItem.name,
          quantidade: existingItem.quantidade - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
