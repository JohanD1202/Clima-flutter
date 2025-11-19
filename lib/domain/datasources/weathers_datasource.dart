import 'package:weather_app/domain/entities/city.dart';
import 'package:weather_app/domain/entities/weather.dart';

abstract class WeathersDatasource {
  Future <Weather> getCurrentWeatherByCity(String city);

  Future<Weather> getCurrentWeatherByLocation({
    required double lat,
    required double lon,
  });

  Future<List<City>> searchCities(String query);
}