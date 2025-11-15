import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/providers/weather/weather_repository_provider.dart';

final weatherByLocationProvider = FutureProvider.family<Weather, Map<String, double>>(
  (ref, coords) async {
    final repo = ref.watch(weatherRepositoryProvider);
    final lat = coords['lat']!;
    final lon = coords['lon']!;
    return repo.getCurrentWeatherByLocation(lat: lat, lon: lon);
  },
);
