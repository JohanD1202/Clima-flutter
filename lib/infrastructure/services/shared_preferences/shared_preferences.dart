import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  // Devuelve la lista de ciudades guardadas, o lista vacía si no hay ninguna
  return prefs.getStringList('favorites') ?? [];
}

Future<void> toggleFavorite(String city) async {
  final prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];

  if (favorites.contains(city)) {
    favorites.remove(city);
  } else {
    favorites.add(city);
  }

  await prefs.setStringList('favorites', favorites);
}

