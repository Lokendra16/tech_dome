import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_dome_assignment/main.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';
import 'package:tech_dome_assignment/module/movie_details/bloc/movie_bloc.dart';
import 'package:tech_dome_assignment/module/movie_details/bloc/movie_event.dart';
import 'package:tech_dome_assignment/module/movie_details/bloc/movie_state.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieResponse movieDetails;

  const MovieDetailsScreen({super.key, required this.movieDetails});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieBloc movieBloc = MovieBloc();

  bool isFavourite = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _checkFavoriteStatus();

    });
    super.initState();
  }

  Future<void> _checkFavoriteStatus() async {
    bool status = await dbHelper.checkFavourite(widget.movieDetails.title);
      isFavourite = status;
    movieBloc.add(FavouriteEvent());

  }

  toggleEvent() {
    isFavourite = !isFavourite;
    movieBloc.add(FavouriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) => movieBloc,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.movieDetails.posterUrl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.7,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (BuildContext context, String url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                          const Icon(Icons.contact_page_outlined),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black12),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, state) {
                      return Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black12),
                        child: GestureDetector(
                            onTap: () async {
                              await dbHelper.saveFavourite(widget.movieDetails);
                              toggleEvent();
                            },
                            child: Icon(
                              Icons.bookmark,
                              color: isFavourite ? Colors.red : Colors.white,
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
            Text(
              widget.movieDetails.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.movieDetails.imdbId,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
