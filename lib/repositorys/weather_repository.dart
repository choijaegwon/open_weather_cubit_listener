import 'package:open_weather_cubit_listener/exceptions/weather_exception.dart';
import 'package:open_weather_cubit_listener/models/custom_error.dart';
import 'package:open_weather_cubit_listener/models/direct_geocoding.dart';
import 'package:open_weather_cubit_listener/models/weather.dart';
import 'package:open_weather_cubit_listener/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(
          name: directGeocoding.name, country: directGeocoding.country);

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
