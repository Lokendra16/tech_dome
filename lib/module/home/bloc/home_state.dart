import 'package:equatable/equatable.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class GetListSuccessState extends HomeState {
  final List<MovieResponse> response;

  GetListSuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class HomeFailureState extends HomeState {
  final String msg;

  HomeFailureState({required this.msg});

  @override
  List<Object> get props => [];
}

class EmptyState extends HomeState {
  @override
  List<Object> get props => [];
}

class UpdateSearchState extends HomeState {
  @override
  List<Object> get props => [];
}
