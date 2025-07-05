# 🌤️ Flutter Weather Forecast App

A beautiful and responsive weather app built with Flutter that provides real-time weather and a 5-day forecast using the OpenWeatherMap API.

---

### ✨ Features

* **Current Weather:** See live temperature, conditions, humidity, wind, and "feels like" temperature.
* **5-Day Forecast:** Get daily predictions with icons and temperatures.
* **City Search:** Look up weather for any city.
* **Responsive & Smooth UI:** Enjoy a great look and feel on any device with gradients and animations.
* **Reliable:** Built-in error handling for network issues or invalid city names.
* **Efficient:** Uses GetX for smart state management.
* **Clean Code:** Organized with a clear architecture (MVC).

---

### 🛠️ Tech Stack

* **Flutter:** For cross-platform mobile development.
* **GetX:** For state management and navigation.
* **Dio:** For making API requests.
* **OpenWeatherMap API:** Provides weather data.
* **Intl:** For date and time formatting.

---

### 🚀 Get Started

1.  **Prerequisites:** Ensure you have Flutter SDK (>=3.0.0) and Dart SDK (>=2.17.0) installed.

2.  **Clone:**

    ```bash
    git clone [https://github.com/PrijeshBikramShahi/WeatherApp.git](https://github.com/PrijeshBikramShahi/WeatherApp.git)
    cd WeatherApp
    ```

3.  **Install:**

    ```bash
    flutter pub get
    ```

4.  **API Key:**

    * Sign up at [OpenWeatherMap](https://openweathermap.org/) to get a free API key.
    * Replace `'YOUR_OPENWEATHERMAP_API_KEY'` in `lib/weather_service.dart` with your key.

5.  **Run:**

    ```bash
    flutter run
    ```

---

### 📁 Project Structure (Key Files)

* `main.dart`: App's starting point.
* `weather_model.dart`: Data structures for weather info.
* `weather_service.dart`: Handles all API calls.
* `weather_controller.dart`: Manages app data and logic.
* `weather_view.dart`: All the user interface (UI) code.

---

### 🌐 API Details

The app uses OpenWeatherMap's APIs for current weather, 5-day forecasts, and converting city names to coordinates.

---

### 🤝 Contributing

We welcome contributions! Please fork the repository, create a feature branch, commit your changes, and open a Pull Request.

---

### 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---


### 📞 Contact

Prijesh Bikram Shahi - PrijeshBikramShahi - prijeshshahi0@gmail.com
Project Link: https://github.com/PrijeshBikramShahi/WeatherApp

⭐ If you found this project useful, please star it! ⭐
