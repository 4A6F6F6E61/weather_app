import 'dart:async';
import 'dart:convert';

import 'package:weather_app/models/forecast_data.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<Location>> search(String query) async {
  final response = await http.get(
    Uri.parse(
      'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=${dotenv.env['API_KEY']}',
    ),
  );

  if (response.statusCode != 200) {
    return List.empty();
  }
  final List responseData = jsonDecode(response.body);
  List<Location> locations = [];

  for (final item in responseData) {
    final name = item['name'];
    final lat = item['lat'];
    final lon = item['lon'];
    if (name != null && lat != null && lon != null) {
      locations.add(Location(name: name, latitude: lat.toDouble(), longitude: lon.toDouble()));
    }
  }

  return locations;
}

Future<WeatherData?> fetchWeather(Location location) async {
  final response = await http.get(
    Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=${dotenv.env['API_KEY']}&units=metric',
    ),
  );

  if (response.statusCode != 200) {
    return null;
  }

  final Map<String, dynamic> data = jsonDecode(response.body);

  return WeatherData.fromJson(data);
}

Future<List<ForecastDataEntry>?> forecast(Location location) async {
  final response = await http.get(
    Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=${dotenv.env['API_KEY']}&units=metric',
    ),
  );

  if (response.statusCode != 200) {
    return null;
  }

  final Map<String, dynamic> data = jsonDecode(response.body);

  final list = data['list'] as List;

  return list.map((e) => ForecastDataEntry.fromJson(e as Map<String, dynamic>)).toList();
}

String getIconUrl(String id) => 'http://openweathermap.org/img/wn/$id@2x.png';
