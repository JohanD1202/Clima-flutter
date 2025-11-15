import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/infrastructure/services/location/geolocation_service.dart';
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
  Map<String, double>? coords;
  final GeolocationService _geoService = GeolocationService();

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    try {
      // Verificar permisos antes de obtener ubicación
      final permission = await _geoService.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Mostrar explicación en español antes de pedir permisos
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Permiso de ubicación"),
            content: const Text(
              "Necesitamos acceder a tu ubicación para mostrar el clima actual.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Aceptar"),
              )
            ],
          ),
        );
      }

      // Obtener posición (pedirá permisos si es necesario)
      final position = await _geoService.determinePosition();
      setState(() {
        coords = {'lat': position.latitude, 'lon': position.longitude};
      });
    } catch (e) {
      print('❌ Error al obtener ubicación: $e');
      // Coordenadas por defecto si falla
      setState(() {
        coords = {'lat': 3.42, 'lon': -76.52}; // Tuluá por defecto
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (coords == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final weatherAsync = ref.watch(weatherByLocationProvider(coords!));

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
