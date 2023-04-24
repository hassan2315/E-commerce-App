import 'package:flutter/foundation.dart';
import '../model/item.dart';

class FavouritesProvider with ChangeNotifier {
  final List<Item> _favourites = [];

  List<Item> get favourites => _favourites;

  void addToFavourites(Item item) {
    if (!_favourites.contains(item)) {
      _favourites.add(item);
      notifyListeners();
    }
  }

  void removeItem(Item item) {
    _favourites.remove(item);
    notifyListeners();
  }

  void removeFromFavourites(Item item) {
    print("Before removal: $favourites");
    if (_favourites.contains(item)) {
      _favourites.remove(item);
    }
    print("After removal: $favourites");
    notifyListeners();
  }

  bool isFavourite(Item item) {
    return _favourites.contains(item);
  }
}
