import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<int> _favorites = [];

  List<int> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _saveFavoritesToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonFavorites = jsonEncode(_favorites);
    await prefs.setString('favorites', jsonFavorites);
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonFavorites = prefs.getString('favorites');
    if (jsonFavorites != null) {
      List<int> favoritesList = jsonDecode(jsonFavorites).cast<int>();
      _favorites.addAll(favoritesList);
      notifyListeners();
    }
  }

  void addFavorite(int storyId) {
    _favorites.add(storyId);
    _saveFavoritesToPrefs();
    notifyListeners();
  }

  void removeFavorite(int storyId) {
    _favorites.remove(storyId);
    _saveFavoritesToPrefs();
    notifyListeners();
  }
}
