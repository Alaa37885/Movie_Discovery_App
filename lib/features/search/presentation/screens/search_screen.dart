import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:movie_nti_aug/features/search/presentation/widgets/search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242A32),

      appBar: AppBar(
        backgroundColor: const Color(0xff242A32),
        centerTitle: true,

        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),

        actions: const [
          Icon(Icons.info_outline_rounded, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),

        child: Column(
          children: [
            // Search TextField
            TextFormField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Color(0xff67686D)),

                suffixIcon: const Icon(Icons.search, color: Color(0xff67686D)),

                fillColor: const Color(0xff3A3F47),
                filled: true,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),

              onChanged: (value) {
                context.read<SearchCubit>().searchMovies(value);
              },

              style: const TextStyle(color: Colors.white),

              cursorColor: const Color(0xff67686D),
            ),

            const SizedBox(height: 20),

            // Search Results
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  // Loading
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Failure
                  if (state is SearchFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "We are sorry, we cannot find the movie",
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  // Success
                  if (state is SearchSuccess) {
                    final movies = state.movies;

                    // No results
                    if (movies.isEmpty) {
                      return const Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      );
                    }

                    // Results
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return SearchCard(
                          movie: movies[index],
                        );
                      },
                    );
                  }

                  // Initial State
                  return Column(
                    children: [
                      const SizedBox(height: 70),

                      Image.asset(
                        "assets/images/no-results 1.png",
                        width: 150,
                        height: 150,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Search for a movie",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Find your movie by Type title, categories, years, etc",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
