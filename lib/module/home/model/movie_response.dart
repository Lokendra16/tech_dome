

import 'dart:convert';

List<MovieResponse> movieResponseFromJson(String str) => List<MovieResponse>.from(json.decode(str).map((x) => MovieResponse.fromJson(x)));

String movieResponseToJson(List<MovieResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieResponse {
  int id;
  String title;
  String posterUrl;
  String imdbId;

  MovieResponse({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.imdbId,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
    id: json["id"],
    title: json["title"],
    posterUrl: json["posterURL"],
    imdbId: json["imdbId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "posterURL": posterUrl,
    "imdbId": imdbId,
  };
}
