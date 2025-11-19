import 'package:weather_app/domain/entities/city.dart';
import 'package:weather_app/infrastructure/models/open_weather/city_model_response.dart';

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