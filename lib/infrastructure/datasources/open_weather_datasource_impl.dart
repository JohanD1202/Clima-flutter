import 'package:dio/dio.dart';
import 'package:weather_app/config/constants/environment.dart';
import 'package:weather_app/infrastructure/infrastructure.dart';
import '/domain/domain.dart';

class OpenWeatherDatasourceImpl extends WeathersDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.openweathermap.org/data/2.5',
    queryParameters: {
      'appid': Environment.openWeatherKey,
      'units': 'metric',
      'lang': 'es'
    },
  ));

  Weather _jsonToWeather(Map<String, dynamic> json) {
    final openWeatherResponse = OpenWeatherResponse.fromJson(json);
    final Weather weather = WeatherMapper.openWeatherToEntity(openWeatherResponse);
    return weather;
  }

  @override
  Future<Weather> getCurrentWeatherByCity(String city) async {
    final response = await dio.get('/weather', queryParameters: {
      'q': city,
    });
    return _jsonToWeather(response.data);
  }

  @override
  Future<Weather> getCurrentWeatherByLocation({
    required double lat,
    required double lon,
  }) async {
    final response = await dio.get('/weather', queryParameters: {
      'lat': lat,
      'lon': lon,
    });
    return _jsonToWeather(response.data);
  }

  @override
  Future<Weather> getWeatherById(int id) async {
    final resp = await dio.get(
      "/weather",
      queryParameters: {
        "id": id,
      },
    );
  final parsed = OpenWeatherResponse.fromJson(resp.data);
  return WeatherMapper.openWeatherToEntity(parsed);
  }

  @override
Future<List<City>> searchCities(String query) async {
  final response = await dio.get(
    'https://api.openweathermap.org/geo/1.0/direct',
    queryParameters: {
      'q': query,
      'limit': 3,
      'appid': Environment.openWeatherKey,
    },
  );

  final List citiesJson = response.data;

  final cities = citiesJson
      .map((json) => CityModelResponse.fromJson(json))
      .map((model) => CityMapper.cityModelToEntity(model))
      .toList();

  return cities;
}

}