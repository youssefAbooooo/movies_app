import 'package:flutter/material.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/widgets/tv_series_card.dart';
import '../app_colors.dart';

class TvSeriesCategory extends StatelessWidget {
  const TvSeriesCategory({
    super.key,
    required this.title,
    required this.tvSeries,
  });

  final String title;
  final List<TvSeries> tvSeries;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: SizedBox(
            height: 280,
            child: ListView.builder(
              itemCount: tvSeries.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return TvSeriesCard(
                  tvSeries: tvSeries[index],
                  onAddToListTap: () {},
                  onFavouriteTap: () {},
                  onWatchlistTap: () {},
                  onYourRatingTap: () {},
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
