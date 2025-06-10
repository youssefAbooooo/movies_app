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
                // Tagline
                const Text(
                  '"There are no little secrets."',
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
                const Text(
                  'Chris, a former tennis player, looks for work as an instructor. He meets Tom Hewett, a wealthy young man whose sister Chloe falls in love with Chris. But Chris has his eye on Tom\'s fiancee Nola.',
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

                const MovieDetailRow(
                    label: 'Release Date', value: 'October 26, 2005'),
                const MovieDetailRow(label: 'Runtime', value: '2h 4m'),
                const MovieDetailRow(
                    label: 'Genres', value: 'Drama, Thriller, Crime, Romance'),
                const MovieDetailRow(
                    label: 'Rating', value: '7.4/10 (4,154 votes)'),
                const MovieDetailRow(label: 'Status', value: 'Released'),
                const MovieDetailRow(label: 'Language', value: 'EN'),
                const MovieDetailRow(
                    label: 'Countries',
                    value: 'United Kingdom, United States, Luxembourg'),

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

                const MovieDetailRow(label: 'Budget', value: '\$15.0M'),
                const MovieDetailRow(label: 'Box Office', value: '\$85.3M'),

                const SizedBox(height: 8),
                const Text(
                  'Production Companies:',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 4),
                  child: Text(
                    '• BBC Film (GB)',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 4),
                  child: Text(
                    '• Thema Production (LU)',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 4),
                  child: Text(
                    '• Jada Productions (US)',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
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
                              backgroundColor: Colors.grey[700],
                              child: Text(
                                castNames[index]
                                    .split(' ')
                                    .map((name) => name[0])
                                    .join(''),
                                style: const TextStyle(
                                  color: Colors.white,
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

                const MovieDetailRow(label: 'IMDB ID', value: 'tt0416320'),
                const MovieDetailRow(label: 'Popularity', value: '3.3'),
                const MovieDetailRow(label: 'Adult Content', value: 'No'),

                const SizedBox(height: 50), // Extra space at bottom
              ],
            ),
          ),
        ],
      ),
    );
  }
}
