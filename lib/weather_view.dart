import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/weather_model.dart';
import 'weather_controller.dart';

class WeatherView extends StatelessWidget {
  final WeatherController controller = Get.put(WeatherController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlue.shade100],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchBar(),
                SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return _buildLoadingWidget();
                    } else if (controller.errorMessage.value.isNotEmpty) {
                      return _buildErrorWidget();
                    } else if (controller.currentWeather.value != null) {
                      return _buildWeatherContent();
                    } else {
                      return _buildInitialState();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Enter city name...',
                  border: InputBorder.none,
                  icon: Icon(Icons.location_city),
                ),
                onSubmitted: (value) => controller.getWeather(value),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => controller.getWeather(textController.text),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Loading weather data...',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Card(
        color: Colors.red.shade100,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Colors.red, size: 48),
              SizedBox(height: 16),
              Text(
                controller.errorMessage.value,
                style: TextStyle(color: Colors.red.shade800, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.getWeather(textController.text),
                child: Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wb_sunny, size: 64, color: Colors.orange),
              SizedBox(height: 16),
              Text(
                'Welcome to Weather Forecast!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Enter a city name to get current weather and 5-day forecast.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCurrentWeatherCard(),
          SizedBox(height: 20),
          _buildForecastSection(),
        ],
      ),
    );
  }

  Widget _buildCurrentWeatherCard() {
    final weather = controller.currentWeather.value!;
    
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              DateFormat('EEEE, MMM d').format(weather.dateTime),
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  controller.getIconUrl(weather.icon),
                  width: 80,
                  height: 80,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather.temperature.round()}°C',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      weather.description.toUpperCase(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail('Feels like', '${weather.feelsLike.round()}°C'),
                _buildWeatherDetail('Humidity', '${weather.humidity}%'),
                _buildWeatherDetail('Wind', '${weather.windSpeed.round()} m/s'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildForecastSection() {
    final dailyForecasts = controller.getDailyForecast();
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '5-Day Forecast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...dailyForecasts.map((forecast) => _buildForecastItem(forecast)),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(WeatherData forecast) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              DateFormat('EEE').format(forecast.dateTime),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Image.network(
            controller.getIconUrl(forecast.icon),
            width: 40,
            height: 40,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              forecast.description,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Text(
            '${forecast.temperature.round()}°C',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}