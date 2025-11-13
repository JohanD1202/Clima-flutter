import 'package:weather_app/domain/datasources/weathers_datasource.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weathers_repository.dart';

class OpenWeatherRepositoryImpl extends WeathersRepository {

  final WeathersDatasource datasource;

  OpenWeatherRepositoryImpl(this.datasource);

  @override
  Future<Weather> getCurrentWeatherByCity(String city) {
    return datasource.getCurrentWeatherByCity(city);
  }

}