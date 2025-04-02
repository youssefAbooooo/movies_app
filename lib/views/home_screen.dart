import 'package:flutter/material.dart';

import '../widgets/category_section.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String id = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBar(),
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
