import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';

import '../widgets/category_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String id = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Movies',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'App',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.search)],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            spacing: 32,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategorySection(),
              CategorySection(),
              CategorySection(),
              CategorySection(),
            ],
          ),
        ),
      ),
    );
  }
}
