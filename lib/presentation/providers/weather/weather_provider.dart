import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/providers/providers.dart';
import '/domain/domain.dart';

final weatherProvider = FutureProvider.family<Weather, String>((ref, city) async {
  final repo = ref.watch(weatherRepositoryProvider);
  return repo.getCurrentWeatherByCity(city);
});
