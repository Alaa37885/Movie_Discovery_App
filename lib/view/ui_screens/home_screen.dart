import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/cubits/home_cubit/home_cubit.dart';
import "package:carousel_slider/carousel_slider.dart";
import 'package:movie_nti_aug/cubits/now_playing_cubit/now_playing_cubit.dart';
import 'package:movie_nti_aug/cubits/popular_cubit/popular_cubit.dart';
import 'package:movie_nti_aug/cubits/top_rated_cubit/top_rated_cubit.dart';
import 'package:movie_nti_aug/cubits/upcoming_cubit/upcoming_cubit.dart';
import 'package:movie_nti_aug/models/movies_model.dart';

import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getCarouselMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xff242A32),
        appBar: AppBar(
          backgroundColor: const Color(0xff242A32),
          title: const Text(
            "What do you want to watch?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  fillColor: const Color(0xff67686D),
                  filled: true,
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 310,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeCarouselMovieLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HomeCarouselMovieSuccess) {
                      var movies = state.movies;

                      return SizedBox(
                        height: 310,
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 300,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.5,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index, realIndex) => ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                      movieId: movies[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500/${movies[index].posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is HomeCarouselMovieError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const Center(
                      child: Text("Unexpected state"),
                    );
                  },
                ),
              ),
              const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicatorColor: Color(0xff3A3F47),
                dividerHeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: "Now Playing"),
                  Tab(text: "Upcoming"),
                  Tab(text: "Top Rated"),
                  Tab(text: "Popular"),
                ],
              ),
              Expanded(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => NowPlayingCubit()..getNowPlaying(),
                    ),
                    BlocProvider(
                      create: (context) => UpcomingCubit()..getUpcomingMovies(),
                    ),
                    BlocProvider(
                      create: (context) => TopRatedCubit()..getTopRated(),
                    ),
                    BlocProvider(
                      create: (context) => PopularCubit()..getPopular(),
                    ),
                  ],
                  child: TabBarView(
                    children: [
                      BlocBuilder<NowPlayingCubit, NowPlayingState>(
                        builder: (context, state) {
                          if (state is NowPlayingLoading || state is NowPlayingInitial) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is NowPlayingSuccess) {
                            return _buildMovieGrid(state.movies);
                          }
                          if (state is NowPlayingFailure) {
                            return Center(
                                child: Text(state.message, style: const TextStyle(color: Colors.red)));
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<UpcomingCubit, UpcomingState>(
                        builder: (context, state) {
                          if (state is getUpcomingLoading || state is UpcomingInitial) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is getUpcomingSuccess) {
                            return _buildMovieGrid(state.movies);
                          }
                          if (state is getUpcomingFailure) {
                            return Center(
                                child: Text(state.message, style: const TextStyle(color: Colors.red)));
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<TopRatedCubit, TopRatedState>(
                        builder: (context, state) {
                          if (state is TopRatedLoading || state is TopRatedInitial) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is TopRatedSuccess) {
                            return _buildMovieGrid(state.movies);
                          }
                          if (state is TopRatedFailure) {
                            return Center(
                                child: Text(state.message, style: const TextStyle(color: Colors.red)));
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<PopularCubit, PopularState>(
                        builder: (context, state) {
                          if (state is PopularLoading || state is PopularInitial) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is PopularSuccess) {
                            return _buildMovieGrid(state.movies);
                          }
                          if (state is PopularFailure) {
                            return Center(
                                child: Text(state.message, style: const TextStyle(color: Colors.red)));
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieGrid(List<MovieModel> movies) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                    movieId: movies[index].id,
                  ),
                ),
              );
            },
            child: Image.network(
              "https://image.tmdb.org/t/p/w500/${movies[index].posterPath}",
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}


// Rest API
// bloc provider على اعلى مستوى branch اول نقطه عندى فى الكود هو object screen
// bloc make a customize staet neither than set state عشوائية
// bloc builder اقدر اديها الكمية الل اعملها عادة بناء
// emit تقوم بعمل اعادة بناء لل state
// 1 plugin add , add packge (flutter bloc) , bloc provider , bloc builder
// expanded , listview , builder , separated (sized box)

