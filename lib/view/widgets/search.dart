import 'package:flutter/material.dart';
import '../../models/search_model.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    required this.movie,
  });

  final SearchMovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 95,
              height: 120,
              child: movie.posterPath != null && movie.posterPath!.isNotEmpty
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _placeholder(),
                    )
                  : _placeholder(),
            ),
          ),

          const SizedBox(width: 14),

          // Movie Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 4),

                // Rating (Yellow Star)
                Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Color(0xffFF8700),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Color(0xffFF8700),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Genres (Ticket Icon)
                Row(
                  children: [
                    const Icon(
                      Icons.confirmation_number_outlined,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        movie.genres.isNotEmpty
                            ? movie.genres.map((g) => g.name).join(', ')
                            : 'Action',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Release Year (Calendar Icon)
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.releaseDate != null && movie.releaseDate!.length >= 4
                          ? movie.releaseDate!.substring(0, 4)
                          : 'Unknown',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),

                // Runtime (Clock Icon)
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.runtime != null
                          ? '${movie.runtime} minutes'
                          : '139 minutes',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Bookmark Icon (Optional: can be removed if strictly following the image)
          // BlocBuilder<WatchListCubit, WatchListState>(
          //   builder: (context, state) {
          //     bool isSaved = false;
          //     if (state is WatchListSuccess) {
          //       isSaved = state.movies.any((m) => m['id'] == movie.id);
          //     }
          //     return IconButton(
          //       padding: EdgeInsets.zero,
          //       constraints: const BoxConstraints(),
          //       onPressed: () {
          //         if (isSaved) {
          //           context.read<WatchListCubit>().removeFromWatchList(movie.id);
          //         } else {
          //           context.read<WatchListCubit>().addToWatchList(
          //                 id: movie.id,
          //                 title: movie.title,
          //                 posterPath: movie.posterPath,
          //                 voteAverage: movie.voteAverage,
          //                 genres: movie.genres.map((g) => g.name).toList(),
          //                 releaseDate: movie.releaseDate ?? '',
          //                 runtime: movie.runtime,
          //               );
          //         }
          //       },
          //       icon: Icon(
          //         isSaved ? Icons.bookmark : Icons.bookmark_border,
          //         color: isSaved ? const Color(0xff0296E5) : Colors.white,
          //         size: 20,
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xff30363D),
      child: const Center(
        child: Icon(
          Icons.movie,
          color: Colors.grey,
          size: 40,
        ),
      ),
    );
  }
}
