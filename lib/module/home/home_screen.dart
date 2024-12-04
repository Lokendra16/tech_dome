import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_dome_assignment/module/favourites/favourites_screen.dart';
import 'package:tech_dome_assignment/module/home/bloc/home_bloc.dart';
import 'package:tech_dome_assignment/module/home/bloc/home_event.dart';
import 'package:tech_dome_assignment/module/home/bloc/home_state.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';
import 'package:tech_dome_assignment/module/home/widgets/home_items.dart';
import 'package:tech_dome_assignment/module/movie_details/movie_details_screen.dart';
import 'package:tech_dome_assignment/utility/app_constant.dart';
import 'package:tech_dome_assignment/utility/widgets/app_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieResponse> searchList = [];
  List<MovieResponse> movieList = [];
  TextEditingController searchController = TextEditingController();
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    getConnectionStatus();
    getList();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: homeBloc,
      builder: (context, state) {
        if (state is HomeInitialState) {}
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeFailureState) {
          return Scaffold(body: Center(child: Text(state.msg)));
        }
        if (state is GetListSuccessState) {
          movieList.clear();
          movieList.addAll(state.response);
        }
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBarWidget(
                title: AppConstant.home,
                showBackBtn: false,
                action: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const FavouritesScreen()));
                        },
                        child: const Icon(Icons.favorite_border)),
                  ),
                ],
              )),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search Here",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0)),
                  controller: searchController,
                  onChanged: (value) {
                    onSearchQuery(value.trim().toLowerCase());
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: searchController.text.isNotEmpty
                        ? searchList.length
                        : movieList.length,
                    itemBuilder: (context, index) {
                      return searchList.isNotEmpty ||
                              searchController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MovieDetailsScreen(
                                              movieDetails: searchList[index],
                                            )));
                              },
                              child: HomeItems(movieList: searchList[index]))
                          : GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MovieDetailsScreen(
                                              movieDetails: movieList[index],
                                            )));
                              },
                              child: HomeItems(movieList: movieList[index]));
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  getList() async {
    homeBloc.add(GetListEvent());
  }

  getConnectionStatus() {
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((List<ConnectivityResult> result) async {
    //   bool isConnected = await InternetConnection().hasInternetAccess;
    //   setState(() {
    //     isInternetConnected = isConnected;
    //   });
    // });
  }

  onSearchQuery(txt) {
    searchList.clear();
    for (var element in movieList) {
      if (element.title.toLowerCase().contains(txt) ||
          element.title.toUpperCase().contains(txt)) {
        debugPrint("element:$element");
        searchList.add(element);
      }
    }
    homeBloc.add(UpdateSearchEvent());
  }
}
