import '/domain/domain.dart';

abstract class WeathersRepository {
  Future <Weather> getCurrentWeatherByCity(String city);

  Future<Weather> getCurrentWeatherByLocation({
    required double lat,
    required double lon,
  });

  Future<List<City>> searchCities(String query);

  Future<Weather> getWeatherById(int id);
}