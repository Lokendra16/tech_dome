import 'package:equatable/equatable.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieUpdateState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieEmptyState extends MovieState {
  @override
  List<Object> get props => [];
}
