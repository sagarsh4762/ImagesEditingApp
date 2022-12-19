// ignore_for_file: iterable_contains_unrelated_type

import 'package:flutter/cupertino.dart';
import 'package:wallpaper_app/model/Item.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<Item> _item = [];
  List<Item> get itemsid => _item;

  void toggleFavorite(Item item) {
    final isExist = _item.contains(item);
    if (isExist) {
      _item.remove(item);
    } else {
      _item.add(item);
    }
    notifyListeners();
  }

  bool isExist(Item item) {
    final isExist = _item.contains(item);
    return isExist;
  }
}
