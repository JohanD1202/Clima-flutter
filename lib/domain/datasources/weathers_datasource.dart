import 'package:weather_app/domain/entities/weather.dart';

abstract class WeathersDatasource {
  Future <Weather> getCurrentWeatherByCoordinates(double lat, double lon);
}