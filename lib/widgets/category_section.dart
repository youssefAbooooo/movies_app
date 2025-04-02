import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'movie_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Movies',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return MovieCard();
            },
          ),
        ),
      ],
    );
  }
}
