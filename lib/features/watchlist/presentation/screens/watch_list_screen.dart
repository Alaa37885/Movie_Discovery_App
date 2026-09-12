import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/features/watchlist/presentation/cubits/watchlist_cubit/watchlist_cubit.dart';
import 'package:movie_nti_aug/features/watchlist/presentation/cubits/watchlist_cubit/watchlist_state.dart';
import 'package:movie_nti_aug/features/movie_details/presentation/screens/movie_details_screen.dart';
import 'package:movie_nti_aug/features/home/data/models/movies_model.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242A32),

      appBar: AppBar(
        backgroundColor: const Color(0xff242A32),
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Watch list',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff0296E5)),
            );
          } else if (state is WatchlistSuccess) {
            final movies = state.movies;
            return movies.isEmpty
                ? _buildEmptyMovieList()
                : _buildMovieList(movies);
          } else if (state is WatchlistFailure) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // =========================
  // EMPTY MOVIE LIST
  // =========================

  Widget _buildEmptyMovieList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty list icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 20),

          Center(child: Image.asset("assets/images/folder (1) 1.png")),

          Text(
            'There Is No Movie Yet!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Find your movie by Type title,\n'
            'categories, years, etc',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xff67686D),
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // MOVIE LIST
  // =========================

  Widget _buildMovieList(List<MovieModel> movies) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),

      itemCount: movies.length,

      itemBuilder: (context, index) {
        final movie = movies[index];

        return _buildMovieItem(context, movie);
      },
    );
  }

  // =========================
  // MOVIE ITEM
  // =========================

  Widget _buildMovieItem(BuildContext context, MovieModel movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movieId: movie.id),
          ),
        );
      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(bottom: 16),
        color: Colors.transparent, // Ensures the entire area is clickable
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================
            // POSTER
            // =====================
            ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',

                width: 75,
                height: 110,

                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 75,
                    height: 110,
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.movie,
                      color: Colors.grey,
                      size: 30,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 10),

            // =====================
            // MOVIE INFORMATION
            // =====================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie title
                  Text(
                    movie.title ?? 'Unknown Movie',

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),

                      const SizedBox(width: 4),

                      Text(
                        movie.voteAverage?.toStringAsFixed(1) ?? '0.0',

                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // Genre
                  Row(
                    children: const [
                      Icon(
                        Icons.movie_outlined,
                        color: Colors.white70,
                        size: 13,
                      ),

                      SizedBox(width: 4),

                      Text(
                        'Action',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // Release date
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white70,
                        size: 12,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        movie.releaseDate ?? 'Unknown',

                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // Runtime
                  Row(
                    children: const [
                      Icon(Icons.access_time, color: Colors.white70, size: 12),

                      SizedBox(width: 4),

                      Text(
                        '139 minutes',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
