import 'package:dio/dio.dart';
import 'weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static final String _apiKey = dotenv.env['OPENWEATHERMAP_API_KEY']!; 
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _geoUrl = 'https://api.openweathermap.org/geo/1.0';
  
  final Dio _dio = Dio();

   Future<Map<String, double>> getCoordinates(String cityName) async {
    try {
      final response = await _dio.get(
        '$_geoUrl/direct',
        queryParameters: {
          'q': cityName,
          'limit': 1,
          'appid': _apiKey,
        },
      );
      
      if (response.data.isEmpty) {
        throw 'City not found. Please check the city name.';
      }
      
      final location = response.data[0];
      return {
        'lat': location['lat'].toDouble(),
        'lon': location['lon'].toDouble(),
      };
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
   Future<WeatherData> getCurrentWeather(String cityName) async {
    try {
      final coordinates = await getCoordinates(cityName);
   
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'lat': coordinates['lat'],
          'lon': coordinates['lon'],
          'appid': _apiKey,
          'units': 'metric',
        },
      );
      
      return WeatherData.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ForecastData> getForecast(String cityName) async {
    try {
      final coordinates = await getCoordinates(cityName);
      
      final response = await _dio.get(
        '$_baseUrl/forecast',
        queryParameters: {
          'lat': coordinates['lat'],
          'lon': coordinates['lon'],
          'appid': _apiKey,
          'units': 'metric',
        },
      );
      
      return ForecastData.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<WeatherData> getCurrentWeatherByCoordinates(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
        },
      );
      
      return WeatherData.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ForecastData> getForecastByCoordinates(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
        },
      );
      
      return ForecastData.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    switch (error.response?.statusCode) {
      case 404:
        return 'Location not found. Please check the coordinates or city name.';
      case 401:
        return 'Invalid API key. Please check your configuration.';
      case 429:
        return 'Too many requests. Please try again later.';
      default:
        return 'Network error. Please check your internet connection.';
    }
  }
}