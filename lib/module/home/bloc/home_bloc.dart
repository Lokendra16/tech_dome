import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_dome_assignment/main.dart';
import 'package:tech_dome_assignment/module/home/bloc/home_event.dart';
import 'package:tech_dome_assignment/module/home/bloc/home_state.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';
import 'package:tech_dome_assignment/utility/app_constant.dart';
import 'package:tech_dome_assignment/utility/network_connection.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<GetListEvent>(getListApi);
    on<UpdateSearchEvent>(updateSearch);
  }

  FutureOr<void> getListApi(GetListEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    if (await NetworkConnection.isConnected()) {
      List<MovieResponse> response = await repository.getMovieList();
      emit(GetListSuccessState(response: response));
      dbHelper.saveAllMovie(response);
    } else {
      List<MovieResponse> response  = await dbHelper.getAllMovie();
      for(var ele in response){
        debugPrint("query-save-movies-->${ele.title}");
      }
      emit(GetListSuccessState(response: response));
     // emit(HomeFailureState(msg: AppConstant.noInternet));
    }
  }

  updateSearch(UpdateSearchEvent event, Emitter<HomeState> emit) {
    emit(EmptyState());
    emit(UpdateSearchState());
  }
}
