
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_dome_assignment/module/splash/bloc/splash_screen_event.dart';
import 'package:tech_dome_assignment/module/splash/bloc/splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitialState()) {
    on((event, emit) => null);
  }
}
