import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/utils/details_utils.dart';
import 'package:movies_app/widgets/detail_row.dart';
import 'package:movies_app/widgets/movie_details_content.dart';

class TvseriesDetailsContent extends StatelessWidget {
  const TvseriesDetailsContent({super.key, required this.tvSeries});

  final TvSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tagline
            if (tvSeries.tagline != '')
              Text(
                '"${tvSeries.tagline}"',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            // Poster and basic info row
            const SizedBox(height: 8),
            // Rating
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '8.5',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '/10',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[400],
                      ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Seasons and episodes info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withOpacity(0.5)),
              ),
              child: Text(
                '${tvSeries.numberOfSeasons} Seasons • ${tvSeries.numberOfEpisodes} Episodes',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),

            const SizedBox(height: 24),

            // Genres
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...tvSeries.genres.map((genre) => _buildGenreChip(genre))
              ],
            ),

            const SizedBox(height: 24),

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
              tvSeries.overView,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // Series details
            Text(
              'Series Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 16),
            DetailRow(label: 'Status', value: tvSeries.status),
            DetailRow(
                label: 'First Air Date',
                value: DetailsUtils.formateDate(tvSeries.firstAirDate)),
            DetailRow(
                label: 'Last Air Date',
                value: DetailsUtils.formateDate(tvSeries.lastAirDate)),
            DetailRow(
                label: 'Seasons', value: tvSeries.numberOfSeasons.toString()),
            DetailRow(
                label: 'Episodes', value: tvSeries.numberOfEpisodes.toString()),
            DetailRow(label: 'Networks', value: tvSeries.networks.join(', ')),
            DetailRow(
                label: 'Languages',
                value: DetailsUtils.getLanguageName(tvSeries.language)),
            DetailRow(
                label: 'Countries',
                value: DetailsUtils.getCountryNames(tvSeries.originCountries)),

            const SizedBox(height: 24),
            const Text(
              'Production',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Production Companies:',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...tvSeries.productioCompanies.map(
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
                itemCount: tvSeries.actors.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 90,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.avatar,
                          child: tvSeries.actors[index].image == ''
                              ? Text(
                                  tvSeries.actors[index].name
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
                                    'https://image.tmdb.org/t/p/w500${tvSeries.actors[index].image}',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tvSeries.actors[index].name,
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

            // Similar TV Shows section (placeholder)
            Text(
              'Seasons',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tvSeries.seasons.length,
                itemBuilder: (context, index) {
                  return _buildSeasonCard(tvSeries.seasons[index]);
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
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

  Widget _buildSeasonCard(Season season) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 120,
              height: 170,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${season.poster}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: Icon(
                      Icons.tv,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            season.name,
            style: TextStyle(
              color: Colors.white,
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
  }
}
