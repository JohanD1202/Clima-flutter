import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:weather_app/presentation/providers/weather/weather_by_city.dart';
import 'package:weather_app/presentation/providers/weather/searched_weather_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  textInputAction: TextInputAction.search,

                  onSubmitted:(value) async {
                    final query = value.trim();
                    if (query.isEmpty) return;

                    try {
                      await ref.read(weatherByCityProvider.notifier).search(query);

                      final weather = ref.read(weatherByCityProvider).value;
                      if(weather == null) throw Exception("Ciudad no encontrada");

                      ref.read(searchedWeatherProvider.notifier).update(
                        (state) => [...state, weather],
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ciudad no encontrada")),
                      );
                    }
                  },

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
                ),
              ),
            ),

            const SizedBox(width: 20),

            GestureDetector(
              onTap: () async {
                final lastState = ref.read(weatherByCityProvider);
                final lastCity = lastState.value?.city;

                if(lastCity != null) {
                  try {
                    await ref.read(weatherByCityProvider.notifier).search(lastCity);
                    final weather = ref.read(weatherByCityProvider).value;
                    if (weather != null) {
                      ref.read(searchedWeatherProvider.notifier).update(
                        (state) => [...state, weather],
                      );
                    }
                  } catch (_) {}
                }
              },
              child: const Icon(
                LucideIcons.refreshCcw,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
