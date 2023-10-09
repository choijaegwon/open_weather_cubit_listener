import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_cubit_listener/models/custom_error.dart';
import 'package:open_weather_cubit_listener/models/weather.dart';
import 'package:open_weather_cubit_listener/repositorys/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({
    required this.weatherRepository,
  }) : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    log('state: $state');
    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
      log('state: $state');
    } on CustomError catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));
      log('state: $state');
    }
  }
}
