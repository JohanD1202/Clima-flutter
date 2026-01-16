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
  'getCurrentWeatherByCity lanza excepción cuando Dio falla',
  () async {
    when(
      () => mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/weather'),
        type: DioExceptionType.connectionError,
      ),
    );

    expect(
      () => datasource.getCurrentWeatherByCity('Tuluá'),
      throwsA(isA<DioException>()),
    );

    verify(
      () => mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
    ).called(1);
  },
);

}