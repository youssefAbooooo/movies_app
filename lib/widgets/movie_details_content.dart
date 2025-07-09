import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/utils/details_utils.dart';

import 'package:movies_app/widgets/detail_row.dart';

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
                if (movie.tagline != '')
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
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAvr.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '/10 (${DetailsUtils.formatNumberWithCommas(movie.voteCount)} votes)',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[400],
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Genres
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...movie.genres.map((genre) => _buildGenreChip(genre))
                  ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: AppColors.divider,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.playlist_add,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: AppColors.divider,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          //Icons.favorite
                          Icons.favorite_outline,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: AppColors.divider,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          //Icons.bookmark
                          Icons.bookmark_border_outlined,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: AppColors.divider,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          //Icons.star
                          Icons.star_border,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
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
                DetailRow(
                    label: 'Release Date',
                    value: DetailsUtils.formateDate(movie.releaseDate)),
                DetailRow(
                    label: 'Runtime',
                    value: DetailsUtils.formatruntime(movie.runtime as int)),
                DetailRow(label: 'Status', value: movie.status),
                DetailRow(
                    label: 'Language', value: movie.language.toUpperCase()),
                DetailRow(
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

                DetailRow(
                  label: 'Budget',
                  value: DetailsUtils.formatBigNumbers(movie.budget as int),
                ),
                DetailRow(
                  label: 'Box Office',
                  value: DetailsUtils.formatBigNumbers(movie.revenue as int),
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
                    itemCount: movie.actors.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 90,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.avatar,
                              child: movie.actors[index].image == ''
                                  ? Text(
                                      movie.actors[index].name
                                          .split(' ')
                                          .map((name) => name[0])
                                          .join(''),
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(40),
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w500${movie.actors[index].image}',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie.actors[index].name,
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

                DetailRow(label: 'IMDB ID', value: movie.imdbId),
                DetailRow(
                    label: 'Popularity',
                    value: movie.popularity.toStringAsFixed(1)),
                DetailRow(
                    label: 'Adult Content', value: movie.adult ? 'Yes' : 'No'),

                const SizedBox(height: 50), // Extra space at bottom
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String genre) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        genre,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
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
