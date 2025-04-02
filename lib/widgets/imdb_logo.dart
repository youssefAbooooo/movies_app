import 'package:flutter/material.dart';

import '../app_colors.dart';

class IMDbLogo extends StatelessWidget {
  const IMDbLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppColors.details,
      ),
      child: Text(
        'IMDb',
        style: TextStyle(
          color: AppColors.background,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
