import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';

class DetailsScreenAppBar extends StatelessWidget {
  const DetailsScreenAppBar({
    super.key,
    required this.title,
    required this.poster,
  });

  final String title;
  final String poster;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500.0, // Height when expanded
      floating: false,
      pinned: true, // Keeps the collapsed app bar visible
      snap: false,
      backgroundColor: AppColors.background,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 64, bottom: 16),
        title: Text(
          title,
          style: const TextStyle(
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: AppColors.background,
              ),
            ],
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          children: [
            // Background poster (blurred)
            Positioned.fill(
              child: Image.network(
                "https://image.tmdb.org/t/p/w500$poster",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
