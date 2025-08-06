import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../services/geocoding_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherProvider._internal();
  static final WeatherProvider _instance = WeatherProvider._internal();
  static WeatherProvider get instance => _instance;

  CurrentWeather? _currentWeather;
  List<DailyWeather>? _forecast;
  bool _isLoading = false;
  String? _errorMessage;
  List<String> _currentLocation = ['-37.814', '144.9633']; // Default Melbourne
  String _currentCityName = 'Melbourne'; // Default city name

  CurrentWeather? get currentWeather => _currentWeather;
  List<DailyWeather>? get forecast => _forecast;
  bool get isLoading => _isLoading;
  List<String> get currentLocation => _currentLocation;
  String get currentCityName => _currentCityName;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> updateLocation(List<String> newLocation) async {
    _currentLocation = newLocation;
    
    // Fetch city name using reverse geocoding
    try {
      final cityName = await GeocodingService.getCityFromCoordinates(
        double.parse(newLocation[0]),
        double.parse(newLocation[1]),
      );
      _currentCityName = cityName ?? 'Unknown Location';
    } catch (e) {
      _currentCityName = 'Unknown Location';
    }
    
    notifyListeners();
    fetchWeatherData(_currentLocation);
  }

  Future<void> fetchWeatherData(List<String> location) async {
    try {
      _setLoading(true);
      _setError(null);
      await _getWeatherData(location);
      _setLoading(false);
    } catch (e) {
      _setError('Failed to fetch weather data: $e');
      _setLoading(false);
    }
  }

  Future<Map<String, dynamic>?> _getWeatherData(List<String> location) async {
    final url = _buildApiUrl(location);
    print('Fetching weather from: $url');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey("error") && data['error'] == true) {
        final errorMsg = data["reason"];
        throw Exception("Data fetch failed: $errorMsg");
      }
      print('Response data keys: ${data.keys}');
      _parseWeatherData(data, _currentCityName);
      return data;
    } else {
      throw Exception("HTTP error: ${response.statusCode}");
    }
    return null;
  }

  void _parseWeatherData(Map<String, dynamic> data, String location) {
    try {
      // Parse current weather from hourly data
      final hourlyData = data['hourly'];
      final tempList = hourlyData['temperature_2m'] as List;
      final weatherCodeList = hourlyData['weather_code'] as List;

      if (tempList.isNotEmpty && weatherCodeList.isNotEmpty) {
        _currentWeather = CurrentWeather.fromApiData(
          location: location,
          temperature: tempList[0].toDouble(),
          weatherCode: weatherCodeList[0],
        );
      }

      // Parse 7-day forecast from daily data
      final dailyData = data['daily'];
      final dailyTimeList = dailyData['time'] as List;
      final maxTempList = dailyData['temperature_2m_max'] as List;
      final minTempList = dailyData['temperature_2m_min'] as List;
      final dailyWeatherCodeList = dailyData['weather_code'] as List;

      _forecast = [];
      for (int i = 0; i < dailyTimeList.length && i < 7; i++) {
        _forecast!.add(DailyWeather.fromApiData(
          date: dailyTimeList[i],
          maxTemp: maxTempList[i].toDouble(),
          minTemp: minTempList[i].toDouble(),
          weatherCode: dailyWeatherCodeList[i],
        ));
      }

      print('Parsed weather data: Current temp = ${_currentWeather?.temp}, Forecast count = ${_forecast?.length}');

    } catch (e) {
      throw Exception('Failed to parse weather data: $e');
    }
  }

}

String _buildApiUrl(List<String> location) {
  const String baseURL = 'https://api.open-meteo.com/v1/forecast';
  return '$baseURL?'
      'latitude=${location[0]}&'
      'longitude=${location[1]}&'
      'daily=weather_code,temperature_2m_max,temperature_2m_min&'
      'hourly=temperature_2m,weather_code&timezone=auto&temporal_resolution=native&forecast_hours=1';
}

class CurrentWeather {
  final String location;
  final double temperature;
  final int weatherCode;

  CurrentWeather({
    required this.location,
    required this.temperature,
    required this.weatherCode,
  });

  String get temp => '${temperature.round()}°C';
  String get condition => _getWeatherCondition(weatherCode);

  factory CurrentWeather.fromApiData({
    required String location,
    required double temperature,
    required int weatherCode,
  }) {
    return CurrentWeather(
      location: location,
      temperature: temperature,
      weatherCode: weatherCode,
    );
  }

}

class DailyWeather {
  final String date;
  final double maxTemp;
  final double minTemp;
  final int weatherCode;

  DailyWeather ({
  required this.date,
  required this.maxTemp,
  required this.minTemp,
  required this.weatherCode,
  });

  String get maxTempString => '${maxTemp.round()}°C';
  String get minTempString => '${minTemp.round()}°C';
  String get condition => _getWeatherCondition(weatherCode);
  String get icon => _getWeatherIcon(weatherCode);

  String _getWeatherIcon(int code) {
    switch (code) {
      case 0: return '☀️';
      case 1: case 2: case 3: return '⛅';
      case 45: case 48: return '🌫️';
      case 51: case 53: case 55: return '🌦️';
      case 61: case 63: case 65: return '🌧️';
      case 71: case 73: case 75: return '❄️';
      case 80: case 81: case 82: return '🌦️';
      case 95: return '⛈️';
      default: return '❓';
    }
  }

  factory DailyWeather.fromApiData({
    required String date,
    required double maxTemp,
    required double minTemp,
    required int weatherCode,
  }) {
    return DailyWeather(
      date: date,
      maxTemp: maxTemp,
      minTemp: minTemp,
      weatherCode: weatherCode,
    );
  }

}

String _getWeatherCondition(int code) {
  switch (code) {
    case 0: return 'Clear sky';
    case 1: case 2: case 3: return 'Partly cloudy';
    case 45: case 48: return 'Fog';
    case 51: case 53: case 55: return 'Light rain';
    case 61: case 63: case 65: return 'Rain';
    case 71: case 73: case 75: return 'Snow';
    case 80: case 81: case 82: return 'Rain showers';
    case 95: return 'Thunderstorm';
    default: return 'Unknown';
  }
}


