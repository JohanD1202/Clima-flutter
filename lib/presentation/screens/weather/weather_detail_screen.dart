import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/widgets/weather/weather_info.dart';

class WeatherDetailScreen extends StatelessWidget {

  static const name = 'weather-detail-screen';
  final Weather weather;

  const WeatherDetailScreen({
    super.key,
    required this.weather
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: GestureDetector(
            child: const Icon(
              LucideIcons.arrowLeft,
              size: 30,
              color: Colors.black,
            ),
            onTap: () => context.pop(),
          ),
        ),
      ),
      body: WeatherInfo(weather: weather),
    );
  }
}