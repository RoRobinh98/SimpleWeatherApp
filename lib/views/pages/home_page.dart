import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test2learn/provider/weather_provider.dart';
import 'package:test2learn/widgets/single_day_weather.dart';
import 'package:test2learn/widgets/weather_now.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _weatherTimer;
  static const _refreshInterval = Duration(seconds: 60);
  static const _melbourneCoords = ['-37.814', '144.9633'];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _startPeriodicRefresh();
  }

  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchWeatherData();
    });
  }

  void _startPeriodicRefresh() {
    _weatherTimer = Timer.periodic(_refreshInterval, (_) {
      _fetchWeatherData();
    });
  }

  void _fetchWeatherData() {
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeatherData(_melbourneCoords);
  }

  @override
  void dispose() {
    _weatherTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WeatherNow(),
        Expanded(
          child: SingleChildScrollView(
            child: SingleDayWeather(),
          ),
        ),
      ],
    );
  }
}
