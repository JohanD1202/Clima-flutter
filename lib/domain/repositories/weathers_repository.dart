import 'package:weather_app/domain/entities/weather.dart';

abstract class WeathersRepository {
  Future <Weather> getCurrentWeatherByCity(String city);

  Future<Weather> getCurrentWeatherByLocation({
    required double lat,
    required double lon,
  });
}