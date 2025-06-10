import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/movie_datails_app_bar.dart';
import 'package:movies_app/widgets/movie_details_content.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  static const String id = '/movieDetailScreen';
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MovieDetailsAppBar(movie: movie),
          MovieDetailsContent(movie: movie),
        ],
      ),
    );
  }
}
