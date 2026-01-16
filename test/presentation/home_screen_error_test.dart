import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/presentation/screens/screens.dart';
import 'package:weather_app/presentation/providers/providers.dart';
import 'package:weather_app/presentation/widgets/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Muestra diálogo cuando no hay conexión a internet',
    (tester) async {
      const MethodChannel locationChannel =
          MethodChannel('flutter.baseflow.com/geolocator');

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(locationChannel, (methodCall) async {
        throw PlatformException(code: 'ERROR');
      });

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            connectivityStatusProvider.overrideWith(
              (ref) => Stream.value(ConnectivityResult.none),
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

      expect(find.byType(AlertDialog), findsOneWidget);

      expect(
        find.text('Sin conexión a internet'),
        findsOneWidget,
      );

      expect(find.byType(WeatherInfo), findsNothing);
    },
  );
}
