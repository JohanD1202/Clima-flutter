# Clima Flutter

Aplicación móvil de clima desarrollada en Flutter, siguiendo principios de Arquitectura Limpia y un enfoque modular. Permite consultar el clima en tiempo real ofreciendo una experiencia moderna, fluida y personalizable.

# *Características principales*

# *Geolocalización*
- Detecta automáticamente la ubicación actual del usuario para mostrar el clima local.

# *Búsqueda de ciudades*
- Barra de búsqueda con autocompletado usando la api de GeoDBCities.

# *Información detallada del clima*
- Temperatura actual (°C / °F)
- Sensación térmica
- Presión atmosférica
- Humedad
- Velocidad del viento
- Estado general del clima

# *Interfaz moderna*
- UI responsiva.
- Animaciones fluidas.
- Fondos dinámicos que cambian según las condiciones del clima (soleado, nublado, lluvia, etc.).

# *Persistencia de datos*
Usando `shared_preferences`:
- Ciudades favoritas.
- Idioma (Español / Inglés).
- Tema (claro / oscuro).
- Unidad de temperatura (C° / F°).

# *Manejo de conectividad*
- Detección de conexión a Internet.
- Diálogo bloqueante cuando no hay conexión.
- Prevención de llamadas innecesarias a la API.

# *Testing*
La aplicación cuenta con tests reales y funcionales, enfocados en lógica y UI:
## Unit Tests
- Mappeo correcto de datos completos y nulos
- Verifican el correcto funcionamiento de datasources y repositories
## Widget Tests
- Visualización correcta de la información del clima cuando hay datos.
- Comportamiento de la pantalla principal cuando no hay conexión a internet.


# *Arquitectura*
- La aplicación sigue Arquitectura limpia, separando responsabilidades (Domain, Infrastructure, Presentation). Facilitando mantenibilidad, escalabilidad y testing.

# *Tecnologías usadas*
- Flutter
- `Riverpod` para gestión de estado
- `shared_preferences`
- `connectivity_plus`
- `geolocator`
- API de `WeatherAPI.com` para datos meteorológicos.
- API de `GeoDBCities` para sugerencias.

# Configuración del proyecto

1. Copia el archivo `.env.template` y renómbralo como `.env`
2. Configura tus llaves


https://github.com/user-attachments/assets/2215141b-c323-48c3-bc70-9fd45b9ad3ce

https://github.com/user-attachments/assets/cc06d0c9-2c03-490d-ae29-d788e5843617

https://github.com/user-attachments/assets/4d8cc366-3017-4a54-bc3a-f859a47c86c2

https://github.com/user-attachments/assets/69578bfc-2c94-4399-8a5f-7c2937b108c1

https://github.com/user-attachments/assets/f580962b-edf4-4097-905b-1d105c71e5eb
