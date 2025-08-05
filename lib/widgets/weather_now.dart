import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test2learn/provider/weather_provider.dart';
class WeatherNow extends StatelessWidget {
  const WeatherNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        if (weatherProvider.isLoading) {
          return SizedBox(
            height: 350,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (weatherProvider.errorMessage != null) {
          return SizedBox(
            height: 350,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Error loading weather',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    weatherProvider.errorMessage!,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        final currentWeather = weatherProvider.currentWeather;
        if (currentWeather == null) {
          return SizedBox(
            height: 350,
            child: Center(child: Text('No weather data available')),
          );
        }

        return SizedBox(
          height: 350,
          child: Column(
            children: [
              Text(
                currentWeather.location,
                style: TextStyle(color: Colors.green, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                currentWeather.temp,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(
                currentWeather.condition,
                style: TextStyle(fontSize: 18, color: Colors.grey[300]),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Lottie.asset('assets/lotties/Weather-partly cloudy.json'),
              ),
            ],
          ),
        );
      },
    );
  }
}
