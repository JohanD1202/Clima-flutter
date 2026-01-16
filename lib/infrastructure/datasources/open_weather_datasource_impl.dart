import 'package:dio/dio.dart';
import '/infrastructure/infrastructure.dart';
import '/domain/domain.dart';

class OpenWeatherDatasourceImpl extends WeathersDatasource {

  final Dio dio;
  final String appId;
  final String geoDbKey;

  OpenWeatherDatasourceImpl(this.dio, {required this.appId, required this.geoDbKey});


  Weather _jsonToWeather(Map<String, dynamic> json) {
    final openWeatherResponse = OpenWeatherResponse.fromJson(json);
    final Weather weather = WeatherMapper.openWeatherToEntity(openWeatherResponse);
    return weather;
  }

  @override
  Future<Weather> getCurrentWeatherByCity(String city) async {
    final response = await dio.get('/weather', queryParameters: {
      'q': city,
    });
    return _jsonToWeather(response.data);
  }

  @override
  Future<Weather> getCurrentWeatherByLocation({
    required double lat,
    required double lon,
  }) async {
    final response = await dio.get('/weather', queryParameters: {
      'lat': lat,
      'lon': lon,
    });
    return _jsonToWeather(response.data);
  }

  @override
  Future<Weather> getWeatherById(int id) async {
    final resp = await dio.get(
      "/weather",
      queryParameters: {
        "id": id,
      },
    );
  final parsed = OpenWeatherResponse.fromJson(resp.data);
  return WeatherMapper.openWeatherToEntity(parsed);
  }

  @override
  Future<List<City>> searchCities(String query) async {
    final response = await dio.get(
      'https://wft-geo-db.p.rapidapi.com/v1/geo/cities',
      queryParameters: {
        'namePrefix': query,
        'limit': 10,
        'sort': '-population'
      },
      options: Options(
        headers: {
        'X-RapidAPI-Key': geoDbKey,
        'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
        }
      )
    );
    final CityModelResponse model = CityModelResponse.fromJson(response.data);

    final filtered = model.data
      .where((c) => c.type == "CITY")
      .toList();

    return filtered.map((c) {
      return City(
        name: c.city,
        country: c.country,
        region: c.region,
        lat: c.latitude,
        lon: c.longitude,
        population: c.population,
        type: c.type
      );
    }).toList();
  }
}