import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/config.dart';
import '/presentation/providers/providers.dart';
import '/infrastructure/infrastructure.dart';

final weatherRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return OpenWeatherRepositoryImpl(OpenWeatherDatasourceImpl(dio, appId: Environment.openWeatherKey, geoDbKey: Environment.geoDbKey));
});