import '../services/location.dart';
import '../services/networking.dart';

const apiKey = 'd01f591ffc7ea94361e0e51ace5dfef5';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2'
    '.5/weather';

class WeatherModel {
  double? latitude;
  double? longitude;

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocattionWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    if (latitude == null || longitude == null) {
      print("Failed to get location coordinates.");
      return null;
    }

    String url =
        '$openWeatherMapURL?lat=${latitude}&lon=${longitude}&units=metric&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();

    if (weatherData == null) {
      print("Failed to fetch weather data.");
      return null;
    }

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
