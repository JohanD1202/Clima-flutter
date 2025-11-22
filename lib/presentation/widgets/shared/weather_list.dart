import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';
import '/presentation/widgets/widgets.dart';
import '/presentation/providers/providers.dart';

class WeatherList extends ConsumerWidget {
  final AsyncValue<Weather> weatherAsync;

  const WeatherList({
    super.key,
    required this.weatherAsync
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedWeatherList = ref.watch(searchedWeatherProvider);
    final isRefreshing = ref.watch(isRefreshingProvider);

    return weatherAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error: $err")),
      data: (currentWeather) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            CurrentLocationCard(weather: currentWeather),

            if(isRefreshing)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ...searchedWeatherList.map(
                (w) => LocationSearchedCard(weather: w),
              ),
          ],
        );
      },
    );
  }
}