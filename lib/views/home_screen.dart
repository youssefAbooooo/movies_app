import 'package:flutter/material.dart';
import 'package:movies_app/widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String id = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movies',
                  style: TextStyle(
                    fontSize: 28,
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
            )
          ],
        ),
      )),
    );
  }
}
