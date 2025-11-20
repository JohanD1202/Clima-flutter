import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:weather_app/config/constants/country_names.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/infrastructure/services/shared_preferences/favorites_provider.dart.dart';

class FavoritesScreen extends ConsumerWidget {

  static const name = "favorites-screen";

  const FavoritesScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Favoritos'),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w600
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            child: const Icon(
              LucideIcons.settings,
              color: Colors.black,
              size: 25,
            ),
          ),
        )
      ],
      ),
      body: favorites.isEmpty
        ? Center(
          child: Text("Aún no tienes ciudades favoritas", 
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600
          )),
        )
        : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final weather = favorites[index];
          return GestureDetector(
            onTap: () => context.push(
              '/weather-detail',
              extra: weather
            ),
            child: _FavoritesCard(
              weather: weather,
              onRemove: () {
                ref
                  .read(favoritesProvider.notifier)
                  .toggle(weather);
              }
            ),
          );
        },
      ),
    );
  }
}

  /*
  List<Weather> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    favorites = await getFavorites();
    setState(() {});
  }

  void _removeFavorite(Weather weather) async {
    await toggleFavorite(weather);
    _loadFavorites();
  }*/

  


class _FavoritesCard extends StatelessWidget {
  final Weather weather;
  final VoidCallback onRemove;

  const _FavoritesCard({
    required this.weather,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {

    final countryFullName = countryNames[weather.country] ?? weather.country;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            _InfoLocationCard(weather.city, countryFullName),
            const Spacer(),
            _InfoTemperatureCard(weather.temperature, weather.description),
            IconButton(
              icon: const Icon(Icons.star),
              color: Colors.yellow,
              iconSize: 25,
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLocationCard extends StatelessWidget {
  
  final String city;
  final String country;

  const _InfoLocationCard(
    this.city,
    this.country
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Text(city, style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 10),
        Text(country, style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500
        )),
      ],
    );
  }
}

class _InfoTemperatureCard extends StatelessWidget {

  final double temperature;
  final String description;

  const _InfoTemperatureCard(
    this.temperature,
    this.description
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('${temperature.toStringAsFixed(1)}°C', 
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        )),
        const SizedBox(height: 3),
        Text(description, style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.right,
        )
      ],
    );
  }
}