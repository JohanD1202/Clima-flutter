import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/domain/entities/weather.dart';

final searchedWeatherProvider = StateProvider<List<Weather>>((ref) => []);
