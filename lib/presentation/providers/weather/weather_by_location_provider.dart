import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/providers/providers.dart';
import '/domain/domain.dart';

final weatherByLocationProvider = FutureProvider.family<Weather, Map<String, double>>(
  (ref, coords) async {
    final repo = ref.watch(weatherRepositoryProvider);
    final lat = coords['lat']!;
    final lon = coords['lon']!;
    return repo.getCurrentWeatherByLocation(lat: lat, lon: lon);
  },
);
