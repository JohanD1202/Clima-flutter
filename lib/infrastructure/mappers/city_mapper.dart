import '/infrastructure/infrastructure.dart';
import '/domain/domain.dart';

class CityMapper {
  static City cityModelToEntity(CityModelResponse openWeatherCity) => City(
    name: openWeatherCity.name,
    country: openWeatherCity.country.trim().isEmpty
      ? 'N/A'
      : openWeatherCity.country,
    state: openWeatherCity.state.trim().isEmpty
      ? 'N/A'
      : openWeatherCity.state,
    lat: openWeatherCity.lat,
    lon: openWeatherCity.lon
  );
}