# Weather App

A Flutter weather application that displays current weather conditions and 7-day forecasts using real-time weather data.

## Features

- **Current Weather Display** - Shows temperature, conditions, and location
- **7-Day Forecast** - Daily weather predictions with high/low temperatures
- **Auto-Refresh** - Updates weather data every 60 seconds
- **Weather Icons** - Visual weather condition indicators
- **Loading States** - Smooth loading indicators and error handling

## Current Implementation

- **Location**: Melbourne, Australia (hard-coded coordinates)
- **Weather Data**: Open-Meteo API integration
- **State Management**: Provider pattern with singleton WeatherProvider
- **UI**: Material Design with bottom navigation
- **Animations**: Lottie animations for weather conditions

## Dependencies

- `provider` - State management
- `http` - API calls for weather data
- `lottie` - Weather animations
- `cupertino_icons` - iOS-style icons

## Getting Started

1. **Clone the repository**
2. **Install dependencies**: `flutter pub get`
3. **Run the app**: `flutter run`

The app will automatically fetch weather data for Melbourne on launch.

## Architecture

- **WeatherProvider**: Singleton pattern managing weather state
- **Weather Models**: `CurrentWeather` and `DailyWeather` data classes
- **Widget Structure**: Modular weather display components
- **Navigation**: Bottom tab navigation between Weather and Location pages

## Known Limitations

- Location is currently hard-coded to Melbourne
- Location page is placeholder (planned for future enhancement)
- Weather animations are static (not weather-condition specific)

## Future Enhancements

- Dynamic location selection with GPS
- City search functionality
- Multiple saved locations
- Weather-specific animations
- User preferences and settings
