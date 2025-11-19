import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/domain/entities/city.dart';
import 'package:weather_app/presentation/providers/weather/weather_repository_provider.dart';

final citySuggestionProvider = FutureProvider.family<List<City>, String>((ref, query) async {

  // Si está vacío, no buscamos nada
  if (query.trim().isEmpty) return [];

  final repository = ref.read(weatherRepositoryProvider);

  return await repository.searchCities(query);
});
