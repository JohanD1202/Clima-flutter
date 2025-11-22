import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/infrastructure/infrastructure.dart';

final weatherRepositoryProvider = Provider((ref) {
  return OpenWeatherRepositoryImpl(OpenWeatherDatasourceImpl());
});