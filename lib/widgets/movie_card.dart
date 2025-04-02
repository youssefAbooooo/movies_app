import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';

import 'imdb_logo.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, "/details", arguments: movie);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network("https://image.tmdb.org/t/p/w500${movie.posterPath}"),
            // Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold)),
            // Text("⭐ ${movie.rating.toString()}")
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500/8ZTVqvKDQ8emSGUEMjsS4yHAwrp.jpg",
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
                    "Inception",
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
                          Text('8.4'),
                        ],
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: AppColors.details,
                          ),
                          Text('3h 5m'),
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
