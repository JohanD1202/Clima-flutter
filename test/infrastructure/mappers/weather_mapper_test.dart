import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/infrastructure/infrastructure.dart';

void main() {
  group('WeatherMapper', () {
    test('Debe mapear correctamente un OpenWeatherResponse completo', () {
      final model = OpenWeatherResponse(
        coord: Coord(
          lon: 1.5,
          lat: 2.5
        ),
        weather: [],
        base: 'base test',
        main: Main(
          temp: 30.0,
          feelsLike: 20.5,
          tempMin: 15.5,
          tempMax: 25.1,
          pressure: 1000,
          humidity: 100,
        ),
        visibility: 1000,
        wind: Wind(
          speed: 100,
          deg: 100
        ),
        clouds: Clouds(
          all: 100
        ),
        dt: 100,
        sys: Sys(
          country: '',
          sunrise: 10,
          sunset: 10
        ),
        timezone: 100,
        id: 10,
        name: 'Weather test',
        cod: 100,
      );

      final weather = WeatherMapper.openWeatherToEntity(model);

      expect(weather.lon, 1.5);
      expect(weather.lat, 2.5);
      expect(weather.visibility, 1000);
      expect(weather.country, 'No disponible');
    });

    test('Debe asignar valores por defecto cuando hay nulls', () {
      final model = OpenWeatherResponse(
        coord: Coord(
          lon: 1.5,
          lat: 2.5
        ),
        weather: [],
        base: 'base test',
        main: Main(
          temp: 30.0,
          feelsLike: 20.5,
          tempMin: 15.5,
          tempMax: 25.1,
          pressure: 1000,
          humidity: 100,
        ),
        visibility: 1000,
        wind: Wind(
          speed: 100,
          deg: 100
        ),
        clouds: Clouds(
          all: 100
        ),
        dt: 100,
        sys: Sys(
          country: '',
          sunrise: 10,
          sunset: 10
        ),
        timezone: 100,
        id: 10,
        name: 'Weather test',
        cod: 100,
      );
      final weather = WeatherMapper.openWeatherToEntity(model);

      expect(weather.description, 'No disponible');
      expect(weather.main, '');
      expect(weather.windGust, 0.0);
      expect(weather.country, 'No disponible');
    });
  });
}
