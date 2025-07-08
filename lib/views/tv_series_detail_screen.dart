import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/cubits/get_tvseries_details_cubit/get_tvseries_details_cubit.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/widgets/datails_Screen_app_bar.dart';
import 'package:movies_app/widgets/tvseries_details_content.dart';

class TvSeriesDetailScreen extends StatefulWidget {
  const TvSeriesDetailScreen({super.key, required this.tvSeries});

  static const String id = '/tvSeriesDetailScreen';
  final TvSeries tvSeries;

  @override
  State<TvSeriesDetailScreen> createState() => _TvSeriesDetailScreenState();
}

class _TvSeriesDetailScreenState extends State<TvSeriesDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<GetTvseriesDetailsCubit>(context)
        .getTvseriesDetials(widget.tvSeries.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with backdrop image
          DetailsScreenAppBar(
            title: widget.tvSeries.title,
            poster: widget.tvSeries.poster,
          ),
          // Main content
          BlocBuilder<GetTvseriesDetailsCubit, GetTvseriesDetailsState>(
            builder: (context, state) {
              if (state is GetTvseriesDetailsLoaded) {
                return TvseriesDetailsContent(tvSeries: state.tvSeries);
              } else if (state is GetTvseriesDetailsLoading) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                );
              } else if (state is GetTvseriesDetailsError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(state.error),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error getting Tv show details'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
