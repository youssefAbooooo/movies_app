import 'package:flutter/material.dart';

import '../widgets/category_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String id = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MyMovies'),
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.search)],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CategorySection()],
          ),
        ),
      ),
    );
  }
}
