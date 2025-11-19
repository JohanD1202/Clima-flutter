import 'package:weather_app/domain/datasources/weathers_datasource.dart';
import 'package:weather_app/domain/entities/city.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weathers_repository.dart';

class OpenWeatherRepositoryImpl extends WeathersRepository {
  final WeathersDatasource datasource;

  OpenWeatherRepositoryImpl(this.datasource);

  @override
  Future<Weather> getCurrentWeatherByCity(String city) {
    return datasource.getCurrentWeatherByCity(city);
  }

  @override
  Future<Weather> getCurrentWeatherByLocation({
    required double lat,
    required double lon,
  }) {
    return datasource.getCurrentWeatherByLocation(lat: lat, lon: lon);
  }

  @override
  Future<List<City>> searchCities(String query) {
    return datasource.searchCities(query);
  }
}
