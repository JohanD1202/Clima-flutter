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
    'searchCities llama al datasource y devuelve lista de ciudades',
    () async {
      final cities = [
        City(
          name: 'Tuluá',
          country: 'Colombia',
          region: 'Region test',
          lat: 1.5,
          lon: 2.5,
          population: null,
          type: '',
        ),
      ];
      when(
        () => mockDatasource.searchCities('Tuluá'),
      ).thenAnswer((_) async => cities);

      final result = await repository.searchCities('Tuluá');

      expect(result, cities);
      verify(() => mockDatasource.searchCities('Tuluá')).called(1);
    },
  );
}
