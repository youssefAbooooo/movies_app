import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/utils/movie_utils.dart';

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
                // Tagline
                Text(
                  '"${movie.tagline}"',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

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
                  style: TextStyle(
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

                MovieDetailRow(label: 'Movie ID', value: movie.id.toString()),
                MovieDetailRow(
                    label: 'Release Date',
                    value: MovieUtils.formateReleaseDate(movie.releaseDate)),
                MovieDetailRow(
                    label: 'Runtime',
                    value: MovieUtils.formatruntime(movie.runtime as int)),
                MovieDetailRow(label: 'Genres', value: movie.genres.join(', ')),
                MovieDetailRow(
                    label: 'Rating',
                    value:
                        '${movie.voteAvr.toStringAsFixed(1)}/10 (${MovieUtils.formatNumberWithCommas(movie.voteCount)} votes)'),
                MovieDetailRow(label: 'Status', value: movie.status),
                MovieDetailRow(
                    label: 'Language', value: movie.language.toUpperCase()),
                MovieDetailRow(
                    label: 'Countries',
                    value: movie.productionCountry.join(', ')),

                const SizedBox(height: 24),

                // Production Information section
                const Text(
                  'Production',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                MovieDetailRow(
                  label: 'Budget',
                  value: MovieUtils.formatBigNumbers(movie.budget as int),
                ),
                MovieDetailRow(
                  label: 'Box Office',
                  value: MovieUtils.formatBigNumbers(movie.revenue as int),
                ),

                const SizedBox(height: 8),
                const Text(
                  'Production Companies:',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...movie.productionCompanies.map(
                  (company) => Company(
                    name: company.name,
                    country: company.originalCountry,
                  ),
                ),
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
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      // Dummy cast names
                      List<String> castNames = [
                        'Jonathan Rhys Meyers',
                        'Scarlett Johansson',
                        'Emily Mortimer',
                        'Matthew Goode',
                        'Brian Cox',
                        'Penelope Wilton'
                      ];

                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 90,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.avatar,
                              child: Text(
                                castNames[index]
                                    .split(' ')
                                    .map((name) => name[0])
                                    .join(''),
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              castNames[index],
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Additional Info section
                const Text(
                  'Additional Info',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                MovieDetailRow(label: 'IMDB ID', value: movie.imdbId),
                MovieDetailRow(
                    label: 'Popularity',
                    value: movie.popularity.toStringAsFixed(1)),
                MovieDetailRow(
                    label: 'Adult Content', value: movie.adult ? 'Yes' : 'No'),

                const SizedBox(height: 50), // Extra space at bottom
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Company extends StatelessWidget {
  const Company({
    super.key,
    required this.name,
    required this.country,
  });

  final String name;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 4),
      child: Text(
        '• $name ($country)',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
      ),
    );
  }
}
