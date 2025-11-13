class Weather {
  final String city;
  final double temperature;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String main;
  final DateTime date;

  const Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.main,
    required this.date,
  });
}
