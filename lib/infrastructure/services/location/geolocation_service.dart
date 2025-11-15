import 'package:geolocator/geolocator.dart';

class GeolocationService {

  // Verificar si la ubicación está activada
  Future<bool> isLocationServiceEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  // Verificar el estado del permiso de ubicación
  Future<LocationPermission> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission;
  }

  // Solicitar el permiso si está denegado.
  Future<LocationPermission> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission;
  }

  //Obtener la ubicación actual del usuario.
  Future<Position> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high
      )
    );
    return position;
  }

  Future<Position> determinePosition() async {
    // GPS activado?
    final serviceEnabled = await isLocationServiceEnabled();
    if(!serviceEnabled) {
      throw Exception('El servicio de ubicación está desactivado.');
    }

    // Estado del permiso actual
    LocationPermission permission = await checkPermission();

    if(permission == LocationPermission.denied) {
      // Solicitar permiso
      permission = await requestPermission();
      if(permission == LocationPermission.denied) {
        throw Exception('El usuario negó el permiso de ubicación.');
      }
    }

    if(permission == LocationPermission.deniedForever) {
      // No podemos pedir permisos
      throw Exception(
        'El permiso está negado permanentemente. Habilítalo desde configuraciones.',
      );
    }
    // Obtener ubicación final
    return await getCurrentLocation();
  }
}
