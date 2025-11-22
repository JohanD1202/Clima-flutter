import '/domain/domain.dart';

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

  @override
  Future<Weather> getWeatherById(int id) {
    return datasource.getWeatherById(id);
  }
}
