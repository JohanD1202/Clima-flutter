import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/infrastructure/infrastructure.dart';

class MockDatasource extends Mock implements WeathersDatasource {}

void main() {
  late MockDatasource mockDatasource;
  late OpenWeatherRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockDatasource();
    repository = OpenWeatherRepositoryImpl(mockDatasource);
  });

  test(
    'getCurrentWeatherByCity llama al datasource y devuelve el clima',
    () async {
      const weather = Weather(
        city: 'Tuluá',
        temperature: 20,
        description: 'Description test',
        feelsLike: 22,
        humidity: 100,
        windSpeed: 100,
        windDeg: 10,
        main: 'Main test',
        country: 'Colombia',
        cloudiness: 1000,
        pressure: 1000,
        timezone: 10,
        visibility: 100,
        tempMin: 18,
        tempMax: 22,
        sunrise: 10,
        sunset: 20,
        windGust: 30,
        lat: 1.5,
        lon: 2.5,
        id: 10,
      );
      when(
        () => mockDatasource.getCurrentWeatherByCity('Tuluá'),
      ).thenAnswer((_) async => weather);

      final result = await repository.getCurrentWeatherByCity('Tuluá');

      expect(result, weather);
      verify(
        () => mockDatasource.getCurrentWeatherByCity('Tuluá'),
      ).called(1);
    },
  );
}
