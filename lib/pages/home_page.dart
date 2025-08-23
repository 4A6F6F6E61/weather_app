import 'package:weather_app/api.dart' as api;
import 'package:weather_app/components/home_header.dart';
import 'package:weather_app/components/hourly_forecast.dart';
import 'package:weather_app/components/info_tile.dart';
import 'package:weather_app/models/forecast_data.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/navigator_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.locationString});

  final String locationString;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherData? weatherData;
  List<ForecastDataEntry>? forecastData;
  late final Location location;

  @override
  void initState() {
    super.initState();
    location = Location.fromString(widget.locationString);
    asyncInit();
  }

  void asyncInit() async {
    final [weatherResult, forecastResult] = await Future.wait([
      api.fetchWeather(location),
      api.forecast(location),
    ]);
    setState(() {
      weatherData = weatherResult as WeatherData?;
      forecastData = forecastResult as List<ForecastDataEntry>?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            navigatorScaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),

        child: SizedBox(
          width: double.maxFinite,
          child: weatherData == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    HomeHeader(weatherData: weatherData!),
                    HourlyForecast(forecastData: forecastData, weatherData: weatherData),
                    extraInfoTiles(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget extraInfoTiles() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: EdgeInsets.only(top: 16),
      children: [
        InfoTile(
          icon: Icons.water_drop,
          title: "Humidity",
          value: "${weatherData!.main.humidity}%",
        ),
        InfoTile(icon: Icons.air, title: "Wind Speed", value: "${weatherData!.wind.speed} m/s"),
        InfoTile(
          icon: Icons.compress,
          title: "Pressure",
          value: "${weatherData!.main.pressure} hPa",
        ),
        InfoTile(
          icon: Icons.visibility,
          title: "Visibility",
          value: "${(weatherData!.visibility / 1000).round()} km",
        ),
        InfoTile(
          icon: Icons.thermostat,
          title: "Min Temp",
          value: "${weatherData!.main.tempMin.round()}°C",
        ),
        InfoTile(
          icon: Icons.thermostat_outlined,
          title: "Max Temp",
          value: "${weatherData!.main.tempMax.round()}°C",
        ),
      ],
    );
  }
}
