import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/infrastructure/models/open_weather/open_weather_response.dart';

class WeatherMapper {
  static Weather openWeatherToEntity(OpenWeatherResponse openWeather) => Weather(
    city: openWeather.name,
    temperature: openWeather.main.temp,
    description: openWeather.weather.isNotEmpty
      ? openWeather.weather.first.description
      : 'No disponible',
    feelsLike: openWeather.main.feelsLike,
    humidity: openWeather.main.humidity,
    windSpeed: openWeather.wind.speed,
    windDeg: openWeather.wind.deg,
    main: openWeather.weather.isNotEmpty
    ? openWeather.weather.first.main
    : '',
    date: DateTime.fromMillisecondsSinceEpoch(openWeather.dt * 1000, isUtc: true),
    country: openWeather.sys.country.isNotEmpty
    ? openWeather.sys.country
    : 'No disponible',
    cloudiness: openWeather.clouds.all,
    pressure: openWeather.main.pressure
  );
}