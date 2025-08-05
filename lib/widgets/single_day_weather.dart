import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test2learn/provider/weather_provider.dart';

class SingleDayWeather extends StatefulWidget {
  const SingleDayWeather({super.key});

  @override
  State<SingleDayWeather> createState() => _SingleDayWeatherState();
}

class _SingleDayWeatherState extends State<SingleDayWeather> {
  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        final forecast = weatherProvider.forecast;
        
        if (forecast == null || forecast.isEmpty) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'No forecast data available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          );
        }

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7-Day Forecast',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 16),
                  ...forecast.map((dayWeather) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            _formatDate(dayWeather.date),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(
                          dayWeather.icon,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: Text(
                            dayWeather.condition,
                            style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                          ),
                        ),
                        Text(
                          '${dayWeather.maxTempString}/${dayWeather.minTempString}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
