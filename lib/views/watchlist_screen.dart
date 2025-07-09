import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/cubits/get_my_watchlist_cubit/get_my_watchlist_cubit.dart';
import 'package:movies_app/services/account_datails_service.dart';
import 'package:movies_app/views/tv_series_detail_screen.dart';
import 'package:movies_app/widgets/tv_series_card.dart';

import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  static const String id = '/watchListScreen';

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  int selectedIndex = 0;
  final List<bool> isSelected = [true, false];

  @override
  void initState() {
    super.initState();
    final accountId = AccountDetailsService().getAccountId();
    final sessionId = AccountDetailsService().getSessionId();
    BlocProvider.of<GetMyWatchlistCubit>(context)
        .getWatchlist(accountId!, sessionId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'My Watchlist',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ToggleButtons(
            borderColor: AppColors.primary,
            fillColor: AppColors.primary,
            selectedBorderColor: AppColors.primary,
            selectedColor: Colors.black,
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(8),
            constraints: const BoxConstraints(minHeight: 40, minWidth: 140),
            isSelected: isSelected,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
                selectedIndex = index;
              });
            },
            children: const [
              Text('Movies'),
              Text('TV Series'),
            ],
          ),
          Expanded(
            child: BlocBuilder<GetMyWatchlistCubit, GetMyWatchlistState>(
              builder: (context, state) {
                if (state is GetMyWatchlistLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                } else if (state is GetMyWatchlistLoaded) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: selectedIndex == 0
                        ? state.movies.length
                        : state
                            .tvseries.length, // Replace with your list length
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of items per row
                      childAspectRatio: 2 / 3, // Width : Height ratio
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return selectedIndex == 0
                          ? MovieCard(
                              movie: state.movies[index],
                              onCardTap: () {
                                Navigator.pushNamed(
                                  context,
                                  MovieDetailsScreen.id,
                                  arguments: state.movies[index],
                                );
                              },
                              onWatchlistTap: () {},
                              onAddToListTap: () {},
                              onFavouriteTap: () {},
                              onYourRatingTap: () {},
                            )
                          : TvSeriesCard(
                              tvSeries: state.tvseries[index],
                              onCardTap: () {
                                Navigator.pushNamed(
                                    context, TvSeriesDetailScreen.id,
                                    arguments: state.tvseries[index]);
                              },
                              onAddToListTap: () {},
                              onFavouriteTap: () {},
                              onWatchlistTap: () {},
                              onYourRatingTap: () {},
                            );
                    },
                  );
                } else if (state is GetMyWatchlistError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: Text('ERROR'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
