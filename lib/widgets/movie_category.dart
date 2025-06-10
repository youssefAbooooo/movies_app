import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/views/movie_detail_screen.dart';

import '../app_colors.dart';
import 'movie_card.dart';

class MovieCategory extends StatelessWidget {
  const MovieCategory({
    super.key,
    required this.title,
    required this.movies,
  });

  final String title;
  final List<Movie> movies;

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
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: movies[index],
                  onCardTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailsScreen.id,
                      arguments: movies[index],
                    );
                  },
                  onPlusTap: () {},
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
