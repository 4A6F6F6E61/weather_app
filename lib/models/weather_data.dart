class WeatherData {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Rain? rain;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  const WeatherData({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  // Factory constructor to create a WeatherData instance from a JSON map.
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List;
    List<Weather> weatherItems = weatherList.map((i) => Weather.fromJson(i)).toList();

    return WeatherData(
      coord: Coord.fromJson(json['coord']),
      weather: weatherItems,
      base: json['base'],
      main: Main.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}

class Coord {
  final double lon;
  final double lat;

  const Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(lon: json['lon'].toDouble(), lat: json['lat'].toDouble());
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int? seaLevel;
  final int? grndLevel;

  const Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }
}

class Wind {
  final double speed;
  final int deg;
  final double? gust;

  const Wind({required this.speed, required this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed'].toDouble(), deg: json['deg'], gust: json['gust']?.toDouble());
  }
}

class Rain {
  final double? oneHour;
  final double? threeHour;

  const Rain({this.oneHour, this.threeHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('1h')) {
      return Rain(oneHour: json['1h']?.toDouble());
    } else if (json.containsKey('3h')) {
      return Rain(threeHour: json['3h']?.toDouble());
    }
    return Rain(oneHour: json['1h']?.toDouble(), threeHour: json['3h']?.toDouble());
  }
}

class Clouds {
  final int all;

  const Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all']);
  }
}

class Sys {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  const Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
