import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:weather_app/presentation/providers/providers.dart';
import 'package:weather_app/presentation/providers/weather/weather_by_location_provider.dart';

class HomeScreen extends StatelessWidget {

  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  final double lat = 10.9685;
  final double lon = -74.7813;

  late final Map<String, double> coords = {'lat': lat, 'lon': lon};

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(weatherByLocationProvider(coords));

    return weatherAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error: $err")),
      data: (weather) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ciudad: ${weather.city}'),
              Text('Temp: ${weather.temperature}°C'),
              Text('Descripción: ${weather.description}'),
            ],
          ),
        ),
      ),
    );
  }
}
