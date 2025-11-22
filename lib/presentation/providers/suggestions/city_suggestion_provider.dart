import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';
import '/presentation/providers/providers.dart';

final citySuggestionProvider = FutureProvider.family<List<City>, String>((ref, query) async {

  if(query.trim().isEmpty) return [];

  final repository = ref.read(weatherRepositoryProvider);

  return await repository.searchCities(query);
});
