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
  'searchCities filtra solo ciudades tipo CITY',
  () async {
    final fakeResponse = {
      "data": [
        {
          "city": "Tuluá",
          "country": "Colombia",
          "region": "Valle",
          "latitude": 4.09,
          "longitude": -76.19,
          "population": 200000,
          "type": "CITY"
        },
        {
          "city": "Fake",
          "country": "Nowhere",
          "region": "X",
          "latitude": 0,
          "longitude": 0,
          "population": 0,
          "type": "ADM2"
        }
      ]
    };

    when(
      () => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: fakeResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final result = await datasource.searchCities('Tu');

    expect(result.length, 1);
    expect(result.first.name, 'Tuluá');
    expect(result.first.country, 'Colombia');
  },
);

}