import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:weather_app/presentation/providers/suggestions/search_query_provider.dart';
import 'package:weather_app/presentation/providers/weather/weather_by_city.dart';
import 'package:weather_app/presentation/providers/weather/searched_weather_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: _TextField(),
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  LucideIcons.refreshCcw,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends ConsumerWidget {
  const _TextField();

  void _onQueryChanged(String value, WidgetRef ref) {
    ref.read(searchQueryProvider.notifier).state = value;
  }

  Future<void> _onSubmitted(
    String value,
    WidgetRef ref,
    BuildContext context
  ) async {
    final query = value.trim();
    if(query.isEmpty) return;

    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(weatherByCityProvider.notifier).search(query);
      final weather = ref.read(weatherByCityProvider).value;
      if(weather == null) throw Exception();
      
      ref.read(searchedWeatherProvider.notifier).update(
        (state) => [...state, weather]
      );
    } catch(e) {
      messenger.showSnackBar(
        const SnackBar(content: Text("Ciudad no encontrada"))
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (value) => _onQueryChanged(value, ref),
      style: const TextStyle(color: Colors.black),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
      hintText: "Ingrese el nombre de la ciudad",
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.lightBlue,
          width: 2,
        ),
      ),
      prefixIcon: const Icon(
        LucideIcons.search,
        color: Colors.black,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
    ),
    onSubmitted:(value) => _onSubmitted(value, ref, context)
    );
  }
}