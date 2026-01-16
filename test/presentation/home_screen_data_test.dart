import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/presentation/screens/screens.dart';
import 'package:weather_app/presentation/providers/providers.dart';
import 'package:weather_app/presentation/widgets/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Muestra información del clima cuando hay datos',
    (tester) async {
      const MethodChannel locationChannel =
          MethodChannel('flutter.baseflow.com/geolocator');

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(locationChannel, (methodCall) async {
        throw PlatformException(code: 'ERROR');
      });

      const fakeWeather = Weather(
        city: 'Tuluá',
        temperature: 25,
        description: 'Soleado',
        feelsLike: 24,
        humidity: 50,
        windSpeed: 3,
        windDeg: 180,
        main: 'Clear',
        country: 'CO',
        cloudiness: 10,
        pressure: 1000,
        timezone: 0,
        visibility: 10000,
        tempMin: 20,
        tempMax: 28,
        sunrise: 0,
        sunset: 0,
        windGust: 0,
        lat: 3.4,
        lon: -76.5,
        id: 1,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            connectivityStatusProvider.overrideWith(
              (ref) => Stream.value(ConnectivityResult.wifi),
            ),

            weatherByLocationProvider.overrideWith(
              (ref, coords) async => fakeWeather,
            ),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.byType(WeatherInfo), findsOneWidget);
      expect(find.text('Tuluá'), findsOneWidget);
    },
  );
}
