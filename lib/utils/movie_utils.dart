import 'package:intl/intl.dart';

class MovieUtils {
  static String formateReleaseDate(String releaseDate) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    String monthNumberString = releaseDate.substring(5, 7);
    // log('MonthNumberString before trimming : $monthNumberString');
    if (monthNumberString[0] == '0') {
      //if the number starts with zero, remove the zero
      monthNumberString = monthNumberString.substring(1);
      // log('MonthNumberString after trimming : $monthNumberString');
    }
    int monthNumber = int.parse(monthNumberString);
    String monthName = months[monthNumber - 1];
    String year = releaseDate.substring(0, 4);
    String day = releaseDate.substring(8, 10);
    return '$monthName $day, $year';
  }

  static String formatruntime(int runtime) {
    int hours = runtime ~/ 60;
    int remaingMinutes = runtime % 60;

    if (hours == 0) return "${remaingMinutes}m";
    if (remaingMinutes == 0) {
      return "${hours}h";
    } else {
      return "${hours}h ${remaingMinutes}m";
    }
  }

  static String formatBigNumbers(int number) {
    if (number >= 1000_000_000_000) {
      return '\$${(number / 1000_000_000_000).toStringAsFixed(1)}T';
    } else if (number >= 1000_000_000) {
      return '\$${(number / 1000_000_000).toStringAsFixed(1)}B';
    } else if (number >= 1000_000) {
      return '\$${(number / 1000_000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '\$${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return '\$$number';
    }
  }

  static String formatNumberWithCommas(num number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}
