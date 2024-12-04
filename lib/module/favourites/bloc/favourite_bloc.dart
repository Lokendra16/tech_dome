
import 'package:bloc/bloc.dart';
import 'package:tech_dome_assignment/main.dart';
import 'package:tech_dome_assignment/module/favourites/bloc/favourite_event.dart';
import 'package:tech_dome_assignment/module/favourites/bloc/favourite_state.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<GetFavouriteListEvent>(getFavouriteList);
  }

  getFavouriteList(GetFavouriteListEvent event, Emitter<FavouriteState> emit) async {
    List<MovieResponse> response = await dbHelper.getFavoriteMovies();
    if (response.isNotEmpty) {
      emit(FavouriteSuccess(movieList: response));
    } else {
      emit(FavouriteFailure(msg: "No Items Found"));
    }
  }
}
