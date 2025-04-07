import 'package:flutter/material.dart';
import 'package:movies_app/cubits/get_tv_series_cubit/get_tv_series_cubit.dart';
import 'package:movies_app/widgets/tv_series_category.dart';

class TvSeriesBody extends StatelessWidget {
  const TvSeriesBody({super.key, required this.state});
  final TvSeriesLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        TvSeriesCategory(
          title: 'Airing Today',
          tvSeries: state.airingToday,
        ),
        TvSeriesCategory(
          title: 'On The Air',
          tvSeries: state.onTheAir,
        ),
        TvSeriesCategory(
          title: 'Popular',
          tvSeries: state.popular,
        ),
        TvSeriesCategory(
          title: 'Top Rated',
          tvSeries: state.topRated,
        ),
      ],
    );
  }
}
