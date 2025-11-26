import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';
import '/presentation/providers/providers.dart';

final citySuggestionProvider = FutureProvider.family<List<City>, String>((ref, query) async {

  final cleanedQuery = query.trim();

  if(cleanedQuery.isEmpty) return [];

  final repository = ref.read(weatherRepositoryProvider);

  return repository.searchCities(cleanedQuery);
});
