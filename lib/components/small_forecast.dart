import 'package:weather_app/api.dart' as api;
import 'package:weather_app/models/forecast_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallForecast extends StatelessWidget {
  const SmallForecast({super.key, required this.first, required this.entry});

  final bool first;
  final ForecastDataEntry entry;

  @override
  Widget build(BuildContext context) {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(entry.dt * 1000);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(first ? "Now" : '${dataTime.hour}', style: GoogleFonts.inter(fontSize: 17)),
        CachedNetworkImage(imageUrl: api.getIconUrl(entry.weather[0].icon), width: 50, height: 50),
        Text('${entry.main.temp.round()}°', style: GoogleFonts.inter(fontSize: 15)),
      ],
    );
  }
}
