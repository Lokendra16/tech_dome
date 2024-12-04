import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tech_dome_assignment/main.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';

class ApiRepository {
  static final ApiRepository repository = ApiRepository.internal();

  factory ApiRepository() {
    return repository;
  }

  static ApiRepository getInstance() => repository;

  ApiRepository.internal();

  Future<List<MovieResponse>> getMovieList() async {
    try {
      final response = await dio.get('/movies/animation');
      List<MovieResponse> res = (response.data as List<dynamic>)
          .map((user) => MovieResponse.fromJson(user))
          .toList();
      return res;
    } catch (e) {
      debugPrint('Error updating user: $e');
      return [];
    }
  }
}
