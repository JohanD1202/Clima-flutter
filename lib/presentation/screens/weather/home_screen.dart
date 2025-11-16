import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/config/constants/country_names.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/infrastructure/services/location/geolocation_service.dart';
import 'package:weather_app/presentation/providers/weather/weather_by_location_provider.dart';
import 'package:weather_app/presentation/widgets/weather/weather_background.dart';
import 'package:weather_app/presentation/widgets/weather/weather_secondary_information.dart';

/*final weather2 = Weather(
  city: "Tuluá",
  temperature: 18.0,
  description: "Lluvia ligera",
  feelsLike: 17.5,
  humidity: 85,
  windSpeed: 5.0,
  windDeg: 210,
  main: "rain",
  date: DateTime.now(),
  country: "Brazil",
  cloudiness: 0,
  pressure: 0
);*/


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
      LocationPermission permission = await _geoService.checkPermission();

      if(permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if(mounted) {
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
    } catch(e) {
      if(!mounted) return;

      setState(() {
        coords = {'lat': 3.42, 'lon': -76.52};
      });
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
        return _WeatherInfo(weather);
      }
    );
  }
}

class _WeatherInfo extends StatelessWidget {

  final Weather weather;

  const _WeatherInfo(this.weather);

  @override
  Widget build(BuildContext context) {

    final countryFullName = countryNames[weather.country] ?? weather.country;

    return Stack(
        children: [
          WeatherBackground(weatherMain: weather.main),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(weather.city, 
                style: GoogleFonts.inter(
                  fontSize: 38,
                  fontWeight: FontWeight.w700
                )),
                const SizedBox(height: 15),
                Text(countryFullName, 
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                )),
                const SizedBox(height: 50),
                Text('${weather.temperature.toStringAsFixed(1)}°C',
                style: GoogleFonts.inter(
                  fontSize: 70,
                  fontWeight: FontWeight.w700,
                  height: 0.9,
                )),
                const SizedBox(height: 15),
                Text(weather.description,
                style:  GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                )),
                const SizedBox(height: 50),
                WeatherSecondaryInformation(
                  feelsLike: weather.feelsLike,
                  windSpeed: weather.windSpeed,
                  windDeg: weather.windDeg,
                  humidity: weather.humidity,
                  cloudiness: weather.cloudiness,
                  pressure: weather.pressure,
                )
              ],
            ),
          )
        ],
      );
  }
}