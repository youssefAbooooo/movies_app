import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/tv_series.dart';

import '../app_colors.dart';
import '../cubits/get_my_watchlist_cubit/get_my_watchlist_cubit.dart';
import '../cubits/watchlist_cubit/watchlist_cubit.dart';
import '../services/account_datails_service.dart';
import '../views/tv_series_detail_screen.dart';
import 'imdb_logo.dart';

class TvSeriesCard extends StatelessWidget {
  const TvSeriesCard({
    super.key,
    required this.tvSeries,
  });
  final TvSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          TvSeriesDetailScreen.id,
          arguments: tvSeries,
        );
      },
      child: Stack(
        children: [
          Container(
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
                                tvSeries.firstAirDate.substring(0, 4),
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
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: PopupMenuButton(
                color: AppColors.surface,
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 24,
                ),
                onSelected: (String result) {
                  switch (result) {
                    case 'add_to_list':
                      debugPrint('add_to_list');
                      // onAddToListTap();
                      break;
                    case 'favourite':
                      debugPrint('favourite');
                      // onFavouriteTap();
                      break;
                    case 'watchlist':
                      debugPrint('watchlist');
                      onWatchlistTap(context);
                      break;
                    case 'rating':
                      debugPrint('your_rating');
                      // onYourRatingTap();
                      break;
                    default:
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'add_to_list',
                    child: Row(
                      children: [
                        Icon(Icons.playlist_add, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text(
                          'Add to List',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'favourite',
                    child: Row(
                      children: [
                        //Icons.favorite
                        Icon(Icons.favorite_border, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text(
                          'Favourite',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'watchlist',
                    child: Row(
                      children: [
                        //Icons.bookmark is the other icon
                        Icon(Icons.bookmark_border_outlined,
                            color: AppColors.primary),
                        SizedBox(width: 8),
                        Text(
                          'Watchlist',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'rating',
                    child: Row(
                      children: [
                        Icon(Icons.star_border, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text(
                          'Your Rating',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onWatchlistTap(BuildContext context) {
    // add the movie to Watchlist
    BlocProvider.of<WatchlistCubit>(context).addOrRemoveFromWatchlist(
      tvSeries.id,
      'tv',
      AccountDetailsService().getAccountId()!,
      AccountDetailsService().getSessionId()!,
      true,
    );
    //refresh the Watchlist screen
    BlocProvider.of<GetMyWatchlistCubit>(context).getWatchlist(
      AccountDetailsService().getAccountId()!,
      AccountDetailsService().getSessionId()!,
    );
  }
}
