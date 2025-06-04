import 'package:flutter/material.dart';
import 'package:movies_app/models/tv_series.dart';

import '../app_colors.dart';
import 'imdb_logo.dart';

class TvSeriesCard extends StatelessWidget {
  const TvSeriesCard({super.key, required this.tvSeries});
  final TvSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, "/details", arguments: movie);
      },
      child: Container(
        margin: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500${tvSeries.poster}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
                left: 4.0,
                bottom: 12,
              ),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tvSeries.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          IMDbLogo(),
                          Text(
                            tvSeries.voteAvr.toStringAsFixed(1),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          Icon(
                            size: 20,
                            Icons.schedule,
                            color: AppColors.primary,
                          ),
                          Text(
                            tvSeries.releaseDate.substring(0, 4),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
