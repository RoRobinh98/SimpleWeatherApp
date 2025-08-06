# Weather App

A Flutter weather application that displays current weather conditions and 7-day forecasts using real-time weather data.

## Features

- **Current Weather Display** - Shows temperature, conditions, and location
- **7-Day Forecast** - Daily weather predictions with high/low temperatures
- **Dynamic Location Selection** - GPS-enabled location picker with Google Maps
- **Auto-Refresh** - Updates weather data every 60 seconds
- **Weather Icons** - Visual weather condition indicators
- **Loading States** - Smooth loading indicators and error handling

## Current Implementation

- **Location**: Dynamic location support with GPS and map selection
- **Weather Data**: Open-Meteo API integration with coordinate-based queries
- **State Management**: Provider pattern with singleton WeatherProvider
- **UI**: Material Design with bottom navigation and Google Maps integration
- **Animations**: Lottie animations for weather conditions

## Dependencies

- `provider` - State management
- `http` - API calls for weather data
- `lottie` - Weather animations
- `cupertino_icons` - iOS-style icons
- `google_maps_flutter` - Interactive map for location selection
- `geolocator` - GPS location services and permissions

## Getting Started

1. **Clone the repository**
2. **Install dependencies**: `flutter pub get`
3. **Run the app**: `flutter run`

The app will request location permissions and fetch weather data for your current location.

## Architecture

- **WeatherProvider**: Singleton pattern managing weather state and location
- **Weather Models**: `CurrentWeather` and `DailyWeather` data classes
- **Location Services**: GPS integration with fallback to default coordinates
- **Widget Structure**: Modular weather display components
- **Navigation**: Bottom tab navigation between Weather and Location pages

## How It Works

1. **Location Detection**: App requests GPS permissions and gets your current location
2. **Map Interaction**: Users can tap anywhere on the map to select a different location  
3. **Location Update**: Selected coordinates are passed to the weather provider
4. **Weather Fetch**: App automatically fetches weather data for the new location
5. **Real-time Updates**: Weather data refreshes every 60 seconds

## Known Limitations

- Weather animations are static (not weather-condition specific)
- Location names are not displayed (shows coordinates only)

## Future Enhancements

- City name display using reverse geocoding
- City search functionality
- Multiple saved locations
- Weather-specific animations
- User preferences and settings
