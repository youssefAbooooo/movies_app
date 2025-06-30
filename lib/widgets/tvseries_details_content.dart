import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/models/tv_series.dart';

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
                '5 Seasons • 50 Episodes',
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

            //TODO Overview section
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

            const SizedBox(height: 24),

            //TODO Cast section (placeholder)

            const SizedBox(height: 24),

            // Similar TV Shows section (placeholder)
            Text(
              'Similar TV Shows',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildSimilarShowCard();
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

  Widget _buildSimilarShowCard() {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 120,
              height: 140,
              child: Image.network(
                'https://via.placeholder.com/120x140',
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
            'Similar Show Title',
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
