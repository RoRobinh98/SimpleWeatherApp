# Weather App

A Flutter weather application that displays current weather conditions and 7-day forecasts using real-time weather data.

## Features

- **Current Weather Display** - Shows temperature, conditions, and city names
- **7-Day Forecast** - Daily weather predictions with high/low temperatures
- **Dynamic Location Selection** - GPS-enabled location picker with Google Maps
- **City Name Display** - Reverse geocoding using Google Maps API to show actual city names
- **Auto-Refresh** - Updates weather data every 60 seconds
- **Weather Icons** - Visual weather condition indicators
- **Loading States** - Smooth loading indicators and error handling

## Current Implementation

- **Location**: Dynamic location support with GPS and map selection
- **Geocoding**: Google Maps API integration for reverse geocoding (coordinates → city names)
- **Weather Data**: Open-Meteo API integration with coordinate-based queries
- **State Management**: Provider pattern with singleton WeatherProvider
- **UI**: Material Design with bottom navigation and Google Maps integration
- **Services Architecture**: Modular service layer for API integrations
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

The app will request location permissions and fetch weather data for your current location with city name display.

## Architecture

- **WeatherProvider**: Singleton pattern managing weather state, location, and city names
- **Weather Models**: `CurrentWeather` and `DailyWeather` data classes
- **Location Services**: GPS integration with fallback to default coordinates
- **Widget Structure**: Modular weather display components
- **Navigation**: Bottom tab navigation between Weather and Location pages

## How It Works

1. **Location Detection**: App requests GPS permissions and gets your current location
2. **Map Interaction**: Users can tap anywhere on the map to select a different location  
3. **Reverse Geocoding**: Google Maps API converts coordinates to city/town names
4. **Location Update**: Selected coordinates and city name are stored in the weather provider
5. **Weather Fetch**: App automatically fetches weather data for the new location
6. **UI Update**: Weather display shows actual city names instead of coordinates
7. **Real-time Updates**: Weather data refreshes every 60 seconds

## Known Limitations

- Weather animations are static (not weather-condition specific)
- Requires Google Maps API key for city name functionality
- Limited to device GPS for current location (no manual city search yet)

## Future Enhancements

- Weather-specific animations based on current conditions
- Offline city name caching
- Weather alerts and notifications
