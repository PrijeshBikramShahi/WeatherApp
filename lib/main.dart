import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/weather_controller.dart';
import 'package:weather_app/weather_service.dart';
import 'weather_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  // ignore: unused_element
  Future<void> main() async { // Make main async
  WidgetsFlutterBinding.ensureInitialized(); // Required
  await dotenv.load(fileName: ".env"); // Load the .env file
  Get.put(WeatherService());
  Get.put(WeatherController());
  runApp(MyApp());
}
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherView(),
      debugShowCheckedModeBanner: false,
    );
  }
}