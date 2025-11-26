import '/domain/domain.dart';
import '/infrastructure/models/open_weather/city_model_response.dart';

class CityMapper {
  static City cityModelToEntity(CityResult model) => City(
    name: model.city,
    country: model.country,
    region: model.region,
    lat: model.latitude,
    lon: model.longitude,
    population: model.population,
  );
}
