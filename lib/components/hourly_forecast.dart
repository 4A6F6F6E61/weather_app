import 'package:weather_app/components/detailed_forecast_sheet.dart';
import 'package:weather_app/components/small_forecast.dart';
import 'package:weather_app/models/forecast_data.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key, required this.forecastData, required this.weatherData});

  final List<ForecastDataEntry>? forecastData;
  final WeatherData? weatherData;

  void showDetailedForecast(BuildContext context) {
    if (forecastData == null) return;
    showModalBottomSheet(
      context: context,
      builder: (context) => DetailedForecastSheet(forecastData: forecastData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 16),
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              if (weatherData?.wind.gust != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    "Wing gusts up to ${weatherData!.wind.gust} m/s are making the temperature feel like ${weatherData!.main.feelsLike.round()}°C",
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
              if (weatherData?.wind.gust != null) Divider(indent: 8, endIndent: 8),
              SizedBox(
                height: 100,
                child: forecastData == null
                    ? Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () => showDetailedForecast(context),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              SmallForecast(first: index == 0, entry: forecastData![index]),
                          separatorBuilder: (context, index) => SizedBox(width: 16),
                          itemCount: forecastData!.length,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
