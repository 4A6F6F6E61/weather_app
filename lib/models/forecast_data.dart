import 'package:weather_app/models/weather_data.dart' as wd;

class ForecastDataEntry {
  const ForecastDataEntry({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    this.rain,
    required this.sys,
    required this.dtTxt,
  });

  final int dt;
  final wd.Main main;
  final List<wd.Weather> weather;
  final wd.Clouds clouds;
  final wd.Wind wind;
  final int visibility;
  final double pop;
  final wd.Rain? rain;
  final wd.Sys sys;
  final String dtTxt;

  factory ForecastDataEntry.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List;
    List<wd.Weather> weatherItems = weatherList.map((i) => wd.Weather.fromJson(i)).toList();

    return ForecastDataEntry(
      dt: json['dt'],
      main: wd.Main.fromJson(json['main']),
      weather: weatherItems,
      clouds: wd.Clouds.fromJson(json['clouds']),
      wind: wd.Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: (json['pop'] as num).toDouble(),
      rain: json['rain'] != null ? wd.Rain.fromJson(json['rain']) : null,
      sys: wd.Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }
}
