import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class GeocodingService {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';

  /// Get city/town name from latitude and longitude coordinates
  static Future<String?> getCityFromCoordinates(double latitude, double longitude) async {
    try {
      final url = Uri.parse(
        '$_baseUrl?latlng=$latitude,$longitude&key=${ApiConfig.googleMapsApiKey}'
      );
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['results'] != null && data['results'].isNotEmpty) {
          final results = data['results'] as List;
          
          // Look for locality (city/town) in the address components
          for (var result in results) {
            final addressComponents = result['address_components'] as List;
            
            for (var component in addressComponents) {
              final types = component['types'] as List;
              
              // Look for locality (city/town) type
              if (types.contains('locality')) {
                return component['long_name'] as String;
              }
              
              // Fallback to administrative_area_level_2 (county/district)
              if (types.contains('administrative_area_level_2')) {
                return component['long_name'] as String;
              }
            }
          }
          
          // If no locality found, return the first formatted address
          return results[0]['formatted_address']?.split(',')[0];
        }
      }
      
      return null;
    } catch (e) {
      print('Error in geocoding: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getCurrentLocationWithCity() async {
    try {
      return null;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }
}