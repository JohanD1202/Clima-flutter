import 'weather_open_weather.dart';

class OpenWeatherResponse {
  final Coord coord;
  final List<WeatherOpenWeather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  OpenWeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory OpenWeatherResponse.fromJson(Map<String, dynamic> json) =>
      OpenWeatherResponse(
        coord: json["coord"] != null
            ? Coord.fromJson(json["coord"])
            : Coord(lon: 0, lat: 0),
        weather: json["weather"] != null
            ? List<WeatherOpenWeather>.from(
                json["weather"].map((x) => WeatherOpenWeather.fromJson(x)))
            : [],
        base: json["base"] ?? '',
        main: json["main"] != null
            ? Main.fromJson(json["main"])
            : Main.empty(),
        visibility: json["visibility"] ?? 0,
        wind: json["wind"] != null
            ? Wind.fromJson(json["wind"])
            : Wind(speed: 0, deg: 0, gust: 0),
        clouds: json["clouds"] != null
            ? Clouds.fromJson(json["clouds"])
            : Clouds(all: 0),
        dt: json["dt"] ?? 0,
        sys: json["sys"] != null
            ? Sys.fromJson(json["sys"])
            : Sys(country: '', sunrise: 0, sunset: 0),
        timezone: json["timezone"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        cod: json["cod"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "base": base,
        "main": main.toJson(),
        "visibility": visibility,
        "wind": wind.toJson(),
        "clouds": clouds.toJson(),
        "dt": dt,
        "sys": sys.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}


class Clouds {
  final int all;
  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) =>
      Clouds(all: json["all"] ?? 0);

  Map<String, dynamic> toJson() => {"all": all};
}

class Coord {
  final double lon;
  final double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: (json["lon"] ?? 0).toDouble(),
        lat: (json["lat"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {"lon": lon, "lat": lat};
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int? seaLevel;
  final int? grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: (json["temp"] ?? 0).toDouble(),
        feelsLike: (json["feels_like"] ?? 0).toDouble(),
        tempMin: (json["temp_min"] ?? 0).toDouble(),
        tempMax: (json["temp_max"] ?? 0).toDouble(),
        pressure: json["pressure"] ?? 0,
        humidity: json["humidity"] ?? 0,
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
      );

  factory Main.empty() => Main(
        temp: 0,
        feelsLike: 0,
        tempMin: 0,
        tempMax: 0,
        pressure: 0,
        humidity: 0,
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
}

class Sys {
  final String country;
  final int sunrise;
  final int sunset;

  Sys({required this.country, required this.sunrise, required this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"] ?? '',
        sunrise: json["sunrise"] ?? 0,
        sunset: json["sunset"] ?? 0,
      );

  Map<String, dynamic> toJson() =>
      {"country": country, "sunrise": sunrise, "sunset": sunset};
}

class Wind {
  final double speed;
  final int deg;
  final double? gust;

  Wind({required this.speed, required this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: (json["speed"] ?? 0).toDouble(),
        deg: json["deg"] ?? 0,
        gust: (json["gust"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() =>
      {"speed": speed, "deg": deg, "gust": gust};
}
