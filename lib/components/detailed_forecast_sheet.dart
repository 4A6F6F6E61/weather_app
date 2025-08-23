import 'package:weather_app/api.dart' as api;
import 'package:weather_app/models/forecast_data.dart';
import 'package:weather_app/util.dart' as util;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailedForecastSheet extends StatelessWidget {
  const DetailedForecastSheet({super.key, required this.forecastData});

  final List<ForecastDataEntry>? forecastData;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          final entry = forecastData![index];
          DateTime entryTime = DateTime.fromMillisecondsSinceEpoch(entry.dt * 1000);
          return ListTile(
            leading: CachedNetworkImage(imageUrl: api.getIconUrl(entry.weather[0].icon)),
            title: Text(
              '${entry.main.temp.round()}°C, ${entry.weather[0].description}',
              style: GoogleFonts.inter(fontSize: 20),
            ),
            subtitle: Text(
              '${util.prettifyDate(entryTime)} - ${entryTime.hour.toString().padLeft(2, '0')}:${entryTime.minute.toString().padLeft(2, '0')}',
              style: GoogleFonts.inter(),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('H: ${entry.main.tempMax.round()}°C', style: GoogleFonts.inter()),
                Text('L: ${entry.main.tempMin.round()}°C', style: GoogleFonts.inter()),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(indent: 8, endIndent: 8),
        itemCount: forecastData!.length,
      ),
    );
  }
}
