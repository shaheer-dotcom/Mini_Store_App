import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  static const _key = 'favorite_ids_v1';
  final Set<int> _ids = {};
  SharedPreferences? _prefs;

  Set<int> get ids => _ids;

  Future<void> loadFavorites() async {
    _prefs = await SharedPreferences.getInstance();
    final list = _prefs?.getStringList(_key);
    if (list != null) {
      _ids.clear();
      _ids.addAll(list.map((e) => int.tryParse(e) ?? -1).where((v) => v != -1));
    }
  }

  Future<void> toggleFavorite(int id) async {
    if (_ids.contains(id)) {
      _ids.remove(id);
    } else {
      _ids.add(id);
    }
    await _save();
    notifyListeners();
  }

  bool isFavorite(int id) => _ids.contains(id);

  Future<void> _save() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setStringList(_key, _ids.map((e) => e.toString()).toList());
  }
}
