import 'package:flutter/material.dart';
import 'package:weather_app/infrastructure/services/shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {

  static const name = "favorites-screen";

  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    favorites = await getFavorites();
    setState(() {});
  }

  void _removeFavorite(String city) async {
    await toggleFavorite(city); // quita del SharedPreferences
    _loadFavorites();           // recarga la lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Favoritos')),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final city = favorites[index];
          return Card(
            child: ListTile(
              title: Text(city),
              trailing: IconButton(
                icon: const Icon(Icons.star),
                color: Colors.yellow,
                onPressed: () => _removeFavorite(city),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FavoritesCard extends StatelessWidget {
  const _FavoritesCard();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
