import 'package:geolocator/geolocator.dart';

class GeolocationService {

  Future<bool> isLocationServiceEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  Future<LocationPermission> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission;
  }

  Future<LocationPermission> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission;
  }

  Future<Position> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high
      )
    );
    return position;
  }

  Future<Position> determinePosition() async {
    final serviceEnabled = await isLocationServiceEnabled();
    if(!serviceEnabled) {
      throw Exception('El servicio de ubicación está desactivado.');
    }

    LocationPermission permission = await checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await requestPermission();
      if(permission == LocationPermission.denied) {
        throw Exception('El usuario negó el permiso de ubicación.');
      }
    }

    if(permission == LocationPermission.deniedForever) {
      throw Exception(
        'El permiso está negado permanentemente. Habilítalo desde configuraciones.',
      );
    }
    return await getCurrentLocation();
  }
}
