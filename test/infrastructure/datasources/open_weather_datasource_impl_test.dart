import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/infrastructure/infrastructure.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late OpenWeatherDatasourceImpl datasource;

  setUp(() {
    mockDio = MockDio();
    datasource = OpenWeatherDatasourceImpl(mockDio, appId: 'fake_api_key', geoDbKey: 'fake_api_key_2');
  });

  test(
    'getCurrentWeatherByCity devuelve el clima de una ciudad cuando se le pasa la ciudad',
    () async {
      // Arrange
      final fakeResponse = {
        "coord": {"lon": 20.0, "lat": 15.0},
        "weather": [
          {
            "id": 800,
            "main": "Main Test",
            "description": "Humedo",
          }
        ],
        "base": "stations",
        "main": {
          "temp": 20.0,
          "feels_like": 22.0,
          "temp_min": 18.0,
          "temp_max": 25.0,
          "pressure": 100,
          "humidity": 100
        },
        "visibility": 1000,
        "wind": {
          "speed": 10.0,
          "deg": 10,
          "gust": 10.0
        },
        "clouds": {"all": 100},
        "dt": 100,
        "sys": {
          "country": "Colombia",
          "sunrise": 10,
          "sunset": 20
        },
        "timezone": 1000,
        "id": 210,
        "name": "Tuluá",
        "cod": 200
      };


      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: fakeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await datasource.getCurrentWeatherByCity('Tuluá');

      expect(result.city, 'Tuluá');
      expect(result.country, 'Colombia');
      expect(result.temperature, 20);

      verify(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).called(1);
    },
  );
}
