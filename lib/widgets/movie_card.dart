import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/models/movie.dart';

import 'imdb_logo.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {super.key,
      required this.movie,
      required this.onCardTap,
      required this.onWatchlistTap,
      required this.onAddToListTap,
      required this.onFavouriteTap,
      required this.onYourRatingTap});

  final Movie movie;
  final VoidCallback onCardTap;
  final VoidCallback onAddToListTap;
  final VoidCallback onFavouriteTap;
  final VoidCallback onWatchlistTap;
  final VoidCallback onYourRatingTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            width: 160,
            height: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.poster}",
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
                        movie.title,
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
                                movie.voteAvr.toStringAsFixed(1),
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
                                movie.releaseDate.substring(0, 4),
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
          // Positioned plus button
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
                      onAddToListTap();
                      break;
                    case 'favourite':
                      debugPrint('favourite');
                      onFavouriteTap();
                      break;
                    case 'watchlist':
                      debugPrint('watchlist');
                      onWatchlistTap();
                      break;
                    case 'rating':
                      debugPrint('your_rating');
                      onYourRatingTap();
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
}
