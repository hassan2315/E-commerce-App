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

  get itemCount {
    return selectedProducts.length;
  }
}
