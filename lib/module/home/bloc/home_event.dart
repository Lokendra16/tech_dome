import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{}

class GetListEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}

class UpdateSearchEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}