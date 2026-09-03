import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/cubits/search_cubit/search_cubit.dart';
import 'movie_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              context.read<SearchCubit>().searchMovies(value);
            },
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

          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                // load
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // success
                if (state is SearchSuccess) {
                  if (state.movies.isEmpty) {
                    return const Center(child: Text("No movies found",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsScreen(movieId: movie.id),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: movie.posterPath != null
                              ? Image.network(
                            "https://image.tmdb.org/t/p/w500${movie
                                .posterPath}",
                            fit: BoxFit.cover,
                          )
                              : Container(
                            color: const Color(0xff3A3F47),
                            child: const Icon(
                              Icons.movie,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                // failure
                if (state is SearchFailure) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                        Text(
                         "we are sorry, we can not find the movie ",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    SizedBox(height: 150,),

                    Center(
                    child: Image.asset(
                    "assets/images/no-results 1.png",
                      width: 150,
                      height: 150,
                      ),
                    ),

                    const Center(
                    child: Column(
                      children: [
                        Text(
                        "Search for a movie",
                        style: TextStyle(color: Colors.white , fontSize: 24),),

                        Text(
                          "Find your movie by Type title, categories, years, etc ",
                          style: TextStyle(color: Colors.white , fontSize: 16),),
                      ],
                    ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
