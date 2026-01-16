import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/config.dart';


final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://api.openweathermap.org/data/2.5',
    queryParameters: {
      'appid': Environment.openWeatherKey,
      'units': 'metric',
      'lang': 'es'
    },
  ));
});