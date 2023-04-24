import 'package:flutter/material.dart';

import '../model/item.dart';

class Cart with ChangeNotifier {
  List selectedProducts = [];
  List get selectP => selectedProducts;

  int price = 0;

  add(Item product) {
    selectedProducts.add(product);
    price += product.price.round();
    notifyListeners();
  }

  delete(Item product) {
    selectedProducts.remove(product);
    price -= product.price.round();

    notifyListeners();
  }

  void incrementQuantity(Item product) {
    product.quantity++;
    price += product.price.round();
    notifyListeners();
  }

  void decrementQuantity(Item product) {
    if (product.quantity > 1) {
      product.quantity--;
      price -= product.price.round();
      notifyListeners();
    }
  }

  get itemCount {
    return selectedProducts.length;
  }
}
