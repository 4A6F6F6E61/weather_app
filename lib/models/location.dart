class Location {
  final double latitude;
  final double longitude;

  final String name;

  const Location({required this.latitude, required this.longitude, required this.name});

  @override
  String toString() {
    return '$name:$latitude:$longitude';
  }

  // Shared Preferences doesn't support objects, so I just save it as a string
  factory Location.fromString(String locationString) {
    final parts = locationString.split(':');
    if (parts.length != 3) {
      throw FormatException('Invalid location string: $locationString');
    }
    final name = parts[0];
    final latitude = double.tryParse(parts[1]);
    final longitude = double.tryParse(parts[2]);
    if (latitude == null || longitude == null) {
      throw FormatException('Invalid latitude or longitude in: $locationString');
    }
    return Location(name: name, latitude: latitude, longitude: longitude);
  }
}
