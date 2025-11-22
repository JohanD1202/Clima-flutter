import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/presentation/screens/weather/weather_detail_screen.dart';
import '/domain/domain.dart';


class FavoritesNotifier extends StateNotifier<List<Weather>> {
  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('favorites') ?? [];
    state = jsonList
        .map((e) => Weather.fromJson(jsonDecode(e)))
        .toList();
  }

  Future<void> toggle(Weather weather) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getStringList('favorites') ?? [];

  final currentList = jsonList
      .map((e) => Weather.fromJson(jsonDecode(e)))
      .toList();

  final id = weather.uniqueId;

  final exists = currentList.any((w) => w.uniqueId == id);

  List<Weather> updated;

  if(exists) {
    updated = currentList.where((w) => w.uniqueId != id).toList();
  } else {
    updated = [...currentList, weather];
  }

  final newJsonList = updated.map((w) => jsonEncode(w.toJson())).toList();
  await prefs.setStringList('favorites', newJsonList);
  state = updated;
}


  Future<void> refresh() async {
    await _loadFavorites();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Weather>>(
  (ref) => FavoritesNotifier(),
);
