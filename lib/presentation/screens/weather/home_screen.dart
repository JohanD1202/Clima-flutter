import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/infrastructure/services/location/geolocation_service.dart';
import 'package:weather_app/presentation/providers/weather/current_location_provider.dart';
import 'package:weather_app/presentation/providers/weather/weather_by_location_provider.dart';
import 'package:weather_app/presentation/widgets/weather/weather_info.dart';

class HomeScreen extends StatefulWidget {

  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
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
      LocationPermission permission = await _geoService.checkPermission();

      if(permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if(mounted) {
          await showDialog(
            context: context,
            builder: (contextDialog) => AlertDialog(
              title: const Text("Permiso de ubicación"),
              content: const Text(
                "Necesitamos acceder a tu ubicación para mostrar el clima actual.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(contextDialog),
                  child: const Text("Aceptar"),
                )
              ],
            ),
          );
        }
        permission = await _geoService.requestPermission(); 

        if(permission == LocationPermission.denied) {
          throw Exception('El usuario negó el permiso de ubicación.');
        } 

        if(permission == LocationPermission.deniedForever) {
          throw Exception(
            'El permiso está negado permanentemente. Habilítalo desde configuraciones.',
          );
        }
      }
      final position = await _geoService.getCurrentLocation();

      if(!mounted) return;
      setState(() {
        coords = {'lat': position.latitude, 'lon': position.longitude};
      });
      ref.read(currentLocationProvider.notifier).state = coords;
    } catch(e) {
      if(!mounted) return;

      setState(() {
        coords = {'lat': 3.42, 'lon': -76.52};
      });
      ref.read(currentLocationProvider.notifier).state = coords;
    }
  }


  @override
  Widget build(BuildContext context) {

    if(coords == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final weatherAsync = ref.watch(weatherByLocationProvider(coords!));
    return weatherAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error: $err")),
      data: (weather)  {
        return WeatherInfo(weather: weather);
      }
    );
  }
}