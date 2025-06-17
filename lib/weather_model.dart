class WeatherData {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final DateTime dateTime;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.dateTime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}

class ForecastData {
  final List<WeatherData> forecasts;

  ForecastData({required this.forecasts});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List<WeatherData> forecasts = [];
    
    for (var item in json['list']) {
      forecasts.add(WeatherData(
        cityName: json['city']['name'],
        temperature: (item['main']['temp'] as num).toDouble(),
        description: item['weather'][0]['description'],
        icon: item['weather'][0]['icon'],
        feelsLike: (item['main']['feels_like'] as num).toDouble(),
        humidity: item['main']['humidity'],
        windSpeed: (item['wind']['speed'] as num).toDouble(),
        dateTime: DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000),
      ));
    }
    
    return ForecastData(forecasts: forecasts);
  }
}