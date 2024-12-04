import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_dome_assignment/module/favourites/bloc/favourite_bloc.dart';
import 'package:tech_dome_assignment/module/favourites/bloc/favourite_event.dart';
import 'package:tech_dome_assignment/module/favourites/bloc/favourite_state.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';
import 'package:tech_dome_assignment/module/home/widgets/home_items.dart';
import 'package:tech_dome_assignment/utility/app_constant.dart';
import 'package:tech_dome_assignment/utility/widgets/app_bar_widget.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  FavouriteBloc favouriteBloc = FavouriteBloc();
  List<MovieResponse> favouriteList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getList();
    });
    super.initState();
  }

  getList() {
    favouriteBloc.add(GetFavouriteListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      bloc: favouriteBloc,
      builder: (context, state) {
        if (state is FavouriteInitial) {}
        if (state is FavouriteLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FavouriteFailure) {
          return Scaffold(body: Center(child: Text(state.msg)));
        }
        if (state is FavouriteSuccess) {
          favouriteList.clear();
          favouriteList.addAll(state.movieList);
        }
        return Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBarWidget(
                title: AppConstant.favourite,
                showBackBtn: true,
              )),
          body: ListView.builder(
              itemCount: favouriteList.length,
              itemBuilder: (context, index) {
                return HomeItems(movieList: favouriteList[index]);
              }),
        );
      },
    );
  }
}
