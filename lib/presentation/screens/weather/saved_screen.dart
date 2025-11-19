import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/config/constants/country_names.dart';
import 'package:weather_app/presentation/providers/suggestions/city_suggestion_provider.dart';
import 'package:weather_app/presentation/providers/suggestions/search_query_provider.dart';
import 'package:weather_app/presentation/providers/weather/current_location_provider.dart';
import 'package:weather_app/presentation/providers/weather/weather_by_city.dart';
import 'package:weather_app/presentation/providers/weather/weather_by_location_provider.dart';
import 'package:weather_app/presentation/providers/weather/searched_weather_provider.dart';
import 'package:weather_app/presentation/widgets/weather/current_location_card.dart';
import 'package:weather_app/presentation/widgets/shared/custom_appbar.dart';
import 'package:weather_app/presentation/widgets/weather/location_searched_card.dart';

class SavedScreen extends ConsumerWidget {
  static const name = "saved-screen";
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coords = ref.watch(currentLocationProvider);

    if (coords == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final weatherAsync = ref.watch(weatherByLocationProvider(coords));
    final searchedWeatherList = ref.watch(searchedWeatherProvider);
    final query = ref.watch(searchQueryProvider);
    final suggestionsAsync = ref.watch(citySuggestionProvider(query));

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(95),
        child: CustomAppbar(),
      ),
      body: Column(
        children: [
          suggestionsAsync.when(
            data: (cities) {
              if(cities.isEmpty) return const SizedBox();
              return Container(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 5)
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: cities.length,
                  itemBuilder: (_, i) {
                    final city = cities[i];

                    final countryFullName = countryNames[city.country] ?? city.country;
                    return ListTile(
                      title: Text("${city.name}, $countryFullName"),
                      subtitle: city.state != null
                          ? Text(city.state!)
                          : null,
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        // Buscar clima de la ciudad seleccionada
                        await ref
                          .read(weatherByCityProvider.notifier)
                          .search(city.name);
                        final weather = ref.read(weatherByCityProvider).value;
                        if(weather != null) {
                          ref
                            .read(searchedWeatherProvider.notifier)
                            .update((state) => [...state, weather]);
                        }

                        // Guardar el nombre en el TextField
                        ref.read(searchQueryProvider.notifier).state = city.name;

                        // Ocultar sugerencias
                        ref.read(searchQueryProvider.notifier).state = '';
                      },
                    );
                  },
                ),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
            error: (_, __) => const SizedBox(),
          ),
          Expanded(
            child: weatherAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text("Error: $err")),
              data: (currentWeather) {
                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    CurrentLocationCard(weather: currentWeather),
            
                    ...searchedWeatherList.map(
                      (weather) => LocationSearchedCard(weather: weather),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
