import 'package:equatable/equatable.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';

abstract class FavouriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteLoading extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteFailure extends FavouriteState {
  final String msg;

  FavouriteFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}

class FavouriteSuccess extends FavouriteState {
  final List<MovieResponse> movieList;

  FavouriteSuccess({required this.movieList});

  @override
  List<Object> get props => [movieList];
}
