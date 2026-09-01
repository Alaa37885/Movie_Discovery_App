import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movie_nti_aug/models/cast_model.dart';
import 'package:movie_nti_aug/models/review_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsCubit()..getMovieDetails(widget.movieId),
      child: Scaffold(
        backgroundColor: const Color(0xff242A32),
        body: SafeArea(
          child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
            builder: (context, state) {
              if (state is MovieDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff0296E5),
                  ),
                );
              }

              if (state is MovieDetailsFailure) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              if (state is MovieDetailsSuccess) {
                final movie = state.movie;

                String year = "";
                if (movie.releaseDate.isNotEmpty &&
                    movie.releaseDate.length >= 4) {
                  year = movie.releaseDate.substring(0, 4);
                }

                String genres = movie.genres.isNotEmpty
                    ? movie.genres.first.name
                    : "";

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Navigation Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  "Detail",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Header Stack (Backdrop + Poster Overlay + Rating Badge)
                      SizedBox(
                        height: 270,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Backdrop Image with Rounded Bottom Corners
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              child: movie.backdropPath != null
                                  ? Image.network(
                                "https://image.tmdb.org/t/p/w780${movie.backdropPath}",
                                width: double.infinity,
                                height: 210,
                                fit: BoxFit.cover,
                              )
                                  : Container(
                                width: double.infinity,
                                height: 210,
                                color: const Color(0xff3A3F47),
                              ),
                            ),

                            // Small Poster Image
                            Positioned(
                              left: 28,
                              top: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: movie.posterPath != null
                                    ? Image.network(
                                  "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                  width: 95,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  width: 95,
                                  height: 120,
                                  color: const Color(0xff3A3F47),
                                ),
                              ),
                            ),

                            // Rating Badge inside Backdrop
                            Positioned(
                              right: 12,
                              bottom: 70,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff252836).withAlpha(180),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star_border,
                                      color: Color(0xffFF8700),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
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
                              ),
                            ),

                            // Movie Title
                            Positioned(
                              left: 140,
                              top: 222,
                              right: 20,
                              child: Text(
                                movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Movie Information Details Bar(year , time , category)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _InfoItem(
                              icon: Icons.calendar_today_outlined,
                              text: year,
                            ),

                            const SizedBox(width: 12),
                            const Text(
                              "|",
                              style: TextStyle(color: Color(0xff696C75)),
                            ),
                            const SizedBox(width: 12),

                            _InfoItem(
                              icon: Icons.access_time,
                              text: "${movie.runtime} Minutes",
                            ),

                            const SizedBox(width: 12),
                            const Text(
                              "|",
                              style: TextStyle(color: Color(0xff696C75)),
                            ),
                            const SizedBox(width: 12),

                            _InfoItem(
                              icon: Icons.confirmation_number_outlined,
                              text: genres,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Tabs Selector Bar(about_movie , reviews , cast)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            _DetailTab(
                              title: "About Movie",
                              isSelected: selectedTabIndex == 0,
                              onTap: () => setState(() => selectedTabIndex = 0),
                            ),
                            _DetailTab(
                              title: "Reviews",
                              isSelected: selectedTabIndex == 1,
                              onTap: () => setState(() => selectedTabIndex = 1),
                            ),
                            _DetailTab(
                              title: "Cast",
                              isSelected: selectedTabIndex == 2,
                              onTap: () => setState(() => selectedTabIndex = 2),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Dynamic Content View Based on Active Tab
                      if (selectedTabIndex == 0)
                        _buildAboutMovie(movie.overview)
                      else if (selectedTabIndex == 1)
                        _buildReviewsList(state.reviews)
                      else if (selectedTabIndex == 2)
                          _buildCastGrid(state.cast),

                      const SizedBox(height: 30),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  // 1. About Movie View
  Widget _buildAboutMovie(String overview) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        overview.isEmpty ? "No description available." : overview,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          height: 1.6,
        ),
      ),
    );
  }

  // 2. Reviews List View
  Widget _buildReviewsList(List<ReviewModel> reviews) {
    if (reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          "No reviews available.",
          style: TextStyle(color: Color(0xff92929D)),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xff6C5ECF),
                  backgroundImage:
                  review.avatarPath != null ? NetworkImage(
                    review.avatarPath!.startsWith('/http')
                        ? review.avatarPath!.substring(1)
                        : "https://image.tmdb.org/t/p/w185${review.avatarPath}",
                  )  : null,

                  child: review.avatarPath == null
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                  ),

                const SizedBox(height: 8),

                Text(
                  review.rating != null
                      ? review.rating!.toStringAsFixed(1)
                      : "-",
                  style: const TextStyle(
                    color: Color(0xff0296E5),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.author,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    review.content,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff92929D),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // 3. Cast Grid View
  Widget _buildCastGrid(List<CastModel> cast) {
    if (cast.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          "No cast info available.",
          style: TextStyle(color: Color(0xff92929D)),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: cast.length,
      itemBuilder: (context, index) {
        final actor = cast[index];
        return Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xff3A3F47),
              backgroundImage: actor.profilePath != null
                  ? NetworkImage(
                  "https://image.tmdb.org/t/p/w185${actor.profilePath}")
                  : null,
              child: actor.profilePath == null
                  ? const Icon(Icons.person, size: 36, color: Colors.white54)
                  : null,
            ),
            const SizedBox(height: 8),
            Text(
              actor.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xff92929D),
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xff92929D),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _DetailTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _DetailTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xff92929D),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xff3A3F47) : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}