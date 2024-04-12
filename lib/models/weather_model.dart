class Weather {
  final String cityName;
  final double temperature;
  final String mainCoundition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCoundition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCoundition: json['weather'][0]['main'],
    );
  }
}
