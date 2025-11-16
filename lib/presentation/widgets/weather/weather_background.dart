import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/presentation/widgets/widgets.dart';
class WeatherBackground extends StatelessWidget {
  final String weatherMain;

  const WeatherBackground({
    super.key,
    required this.weatherMain
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColorsForWeather(weatherMain);

    return LinearGradientSeason(
      colors: colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      child: _buildLottie(),
    );
  }

  List<Color> _getColorsForWeather(String main) {
    main = main.toLowerCase();

    if(main.contains('clear')) {
      return [
        /*Color(0xFF56CCF2),
        Color(0xFF2F80ED)*/
        Color.fromARGB(255, 65, 198, 242),
        Color.fromARGB(255, 74, 160, 188),
        Color.fromARGB(255, 39, 110, 203),
      ];
    }
    if(main.contains('clouds')) {
      //return [Color(0xFF757F9A), Color(0xFFD7DDE8)];
      return [
        Color.fromARGB(255, 90, 97, 117),
        Color.fromARGB(255, 137, 148, 179),
        Color.fromARGB(255, 173, 177, 185),
      ];
    }
    if(main.contains('rain')) {
      return [
        Color.fromARGB(255, 76, 75, 75),
        Color.fromARGB(255, 122, 125, 126),
        Color.fromARGB(255, 203, 202, 202),
      ];
    }
    if(main.contains('thunder') || main.contains('storm')
    || main.contains('thunderstorm')) {
      return [
        /*Color.fromARGB(255, 142, 25, 184),
        Color.fromARGB(255, 205, 94, 245),
        Color.fromARGB(255, 228, 165, 253),*/
        Color.fromARGB(255, 27, 35, 151),
        Color.fromARGB(255, 40, 47, 131),
        Color.fromARGB(255, 57, 68, 164),
        Color.fromARGB(255, 61, 64, 241),
      ];
    }
    if(main.contains('snow')) {
      return [
        /*Color(0xFFe6dada),
        Color(0xFF274046),*/
        Color(0xFFe6dada),
        Color.fromARGB(255, 96, 96, 116),
        Color.fromARGB(255, 56, 72, 76),
      ];
    }
    return [        
      Color.fromARGB(255, 65, 198, 242),
      Color.fromARGB(255, 74, 160, 188),
      Color.fromARGB(255, 39, 110, 203),
    ];
  }

  Widget _buildLottie() {
    if(weatherMain.toLowerCase().contains('rain') || 
    weatherMain.toLowerCase().contains('drizzle')) {
      return _LottieImage('assets/lottie/rain.json');
    } 
    if(weatherMain.toLowerCase().contains('clear')) {
      return _LottieImage('assets/lottie/clear.json');
    }
    if(weatherMain.toLowerCase().contains('snow')) {
      return _LottieImage('assets/lottie/snow.json');
    }
    if(weatherMain.toLowerCase().contains('thunder')
    || weatherMain.toLowerCase().contains('storm')
    || weatherMain.toLowerCase().contains('thunderstorm')) {
      return _LottieImage('assets/lottie/thunder.json');
    }
    if(weatherMain.toLowerCase().contains('clouds')) {
      return _LottieImage('assets/lottie/clouds.json');
    }
    return _LottieImage('assets/lottie/clear.json');
  }
}

class _LottieImage extends StatelessWidget {

  final String name;

  const _LottieImage(
    this.name
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 100),
        Center(
          child: Lottie.asset(
            name,
            fit: BoxFit.cover,
            repeat: true
          ),
        )
      ],
    );
  }
}

