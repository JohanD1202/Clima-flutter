class Weather {
  final String city;
  final double temperature;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final String main;
  final DateTime date;
  final String country;
  final int cloudiness;
  final int pressure;

  const Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.main,
    required this.date,
    required this.country,
    required this.cloudiness,
    required this.pressure
  });
}
