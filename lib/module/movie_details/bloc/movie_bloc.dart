
import 'package:bloc/bloc.dart';
import 'package:tech_dome_assignment/module/movie_details/bloc/movie_event.dart';
import 'package:tech_dome_assignment/module/movie_details/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  MovieBloc() : super(MovieInitial()) {
    on<FavouriteEvent>(toggleBtn);
  }

  toggleBtn(FavouriteEvent event, Emitter<MovieState> emit) {
    emit(MovieEmptyState());
    emit(MovieUpdateState());
  }
}
