import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/presentation/screens/screens.dart';
import 'package:weather_app/presentation/providers/providers.dart';
import 'package:weather_app/presentation/widgets/weather/weather_info.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Muestra diálogo cuando no hay conexión a internet',
    (tester) async {
      // 🔹 Mock del channel de geolocalización (fuerza el catch)
      const MethodChannel locationChannel =
          MethodChannel('flutter.baseflow.com/geolocator');

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(locationChannel, (methodCall) async {
        throw PlatformException(code: 'ERROR');
      });

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // 🔴 Sin internet
            connectivityStatusProvider.overrideWithValue(
              const AsyncData(ConnectivityResult.none),
            ),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      // initState
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));

      // 🔹 El diálogo debe mostrarse
      expect(find.byType(AlertDialog), findsOneWidget);

      // 🔹 Texto del diálogo
      expect(
        find.text('Sin conexión a internet'),
        findsOneWidget,
      );

      // 🔹 No debe mostrarse el clima
      expect(find.byType(WeatherInfo), findsNothing);
    },
  );
}
