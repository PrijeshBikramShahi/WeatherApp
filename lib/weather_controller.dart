import 'package:get/get.dart';
import 'weather_model.dart';
import 'weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();
 
  var isLoading = false.obs;
  var currentWeather = Rxn<WeatherData>();
  var forecastData = Rxn<ForecastData>();
  var errorMessage = ''.obs;
  var searchCity = ''.obs;

  Future<void> getWeather(String cityName) async {
    if (cityName.trim().isEmpty) {
      errorMessage.value = 'Please enter a city name';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';
    
      final results = await Future.wait([
        _weatherService.getCurrentWeather(cityName),
        _weatherService.getForecast(cityName),
      ]);
      
      currentWeather.value = results[0] as WeatherData;
      forecastData.value = results[1] as ForecastData;
      searchCity.value = cityName;
      
    } catch (e) {
      errorMessage.value = e.toString();
      currentWeather.value = null;
      forecastData.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  String getIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  List<WeatherData> getDailyForecast() {
    if (forecastData.value == null) return [];
    
    Map<String, WeatherData> dailyMap = {};
    
    for (var forecast in forecastData.value!.forecasts) {
      String dateKey = '${forecast.dateTime.year}-${forecast.dateTime.month}-${forecast.dateTime.day}';
 
      if (!dailyMap.containsKey(dateKey)) {
        dailyMap[dateKey] = forecast;
      }
    }
    
    return dailyMap.values.take(5).toList();
  }
}