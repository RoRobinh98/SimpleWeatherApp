import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test2learn/provider/weather_provider.dart';
import 'package:test2learn/views/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider.instance,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:ColorScheme.fromSeed(
                seedColor: Colors.teal,
                brightness: Brightness.dark,
            )),
        home: WidgetTree(),
      ),
    );
  }
}
