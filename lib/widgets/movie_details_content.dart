import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/movie_detail_row.dart';

class MovieDetailsContent extends StatelessWidget {
  const MovieDetailsContent({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie info section
                const Text(
                  'Overview',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overView,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Additional movie details
                const Text(
                  'Details',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                MovieDetailRow(label: 'Release Date', value: movie.releaseDate),
                MovieDetailRow(label: 'Duration', value: '2h 30m'),
                MovieDetailRow(label: 'Genre', value: 'Action, Adventure'),
                MovieDetailRow(label: 'Director', value: 'John Doe'),
                MovieDetailRow(
                    label: 'Rating',
                    value: '${movie.voteAvr.toStringAsFixed(1)}/10'),

                const SizedBox(height: 24),

                // Cast section
                const Text(
                  'Cast',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 80,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.person),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Actor ${index + 1}',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50), // Extra space at bottom
              ],
            ),
          ),
        ],
      ),
    );
  }
}
