import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/models/movie.dart';

import 'imdb_logo.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {super.key,
      required this.movie,
      required this.onCardTap,
      required this.onPlusTap});

  final Movie movie;
  final VoidCallback onCardTap;
  final VoidCallback onPlusTap;

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
            child: GestureDetector(
              onTap: () {
                onPlusTap();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Added to Watchlist"),
                    backgroundColor: AppColors.surface,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons
                      .add, //if the movie is added to a watchlist make the icon : Icon.check
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
