import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/util.dart' as util;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(weatherData.dt * 1000);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(weatherData.name, style: GoogleFonts.inter(fontSize: 25)),
        Text(util.prettifyDate(dataTime), style: GoogleFonts.inter(fontSize: 12)),
        Text(
          '${weatherData.main.temp.round()}°C',
          style: GoogleFonts.inter(fontSize: 100, fontWeight: FontWeight.w300),
        ),
        Text(
          "Feels like: ${weatherData.main.feelsLike.round()}°C",
          style: GoogleFonts.inter(fontSize: 20, color: Theme.of(context).colorScheme.primary),
        ),
        Text(
          "H: ${weatherData.main.tempMax.round()}°C L: ${weatherData.main.tempMin.round()}°C",
          style: GoogleFonts.inter(fontSize: 15, color: Theme.of(context).hintColor),
        ),
      ],
    );
  }
}
