import 'package:intl/intl.dart';

class DetailsUtils {
  static String formateDate(String releaseDate) {
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

  static String getLanguageName(String shortName) {
    // Map of language short names to full names (sorted alphabetically by language name)
    final Map<String, String> languageMap = {
      'af': 'Afrikaans',
      'sq': 'Albanian',
      'am': 'Amharic',
      'ar': 'Arabic',
      'hy': 'Armenian',
      'az': 'Azerbaijani',
      'eu': 'Basque',
      'be': 'Belarusian',
      'bn': 'Bengali',
      'bs': 'Bosnian',
      'bg': 'Bulgarian',
      'my': 'Burmese',
      'ca': 'Catalan',
      'zh': 'Chinese',
      'hr': 'Croatian',
      'cs': 'Czech',
      'da': 'Danish',
      'nl': 'Dutch',
      'en': 'English',
      'et': 'Estonian',
      'tl': 'Filipino',
      'fi': 'Finnish',
      'fr': 'French',
      'gl': 'Galician',
      'ka': 'Georgian',
      'de': 'German',
      'gu': 'Gujarati',
      'he': 'Hebrew',
      'hi': 'Hindi',
      'hu': 'Hungarian',
      'is': 'Icelandic',
      'id': 'Indonesian',
      'ga': 'Irish',
      'it': 'Italian',
      'ja': 'Japanese',
      'kn': 'Kannada',
      'kk': 'Kazakh',
      'km': 'Khmer',
      'ko': 'Korean',
      'ky': 'Kyrgyz',
      'lo': 'Lao',
      'lv': 'Latvian',
      'lt': 'Lithuanian',
      'mk': 'Macedonian',
      'ms': 'Malay',
      'ml': 'Malayalam',
      'mt': 'Maltese',
      'mr': 'Marathi',
      'mn': 'Mongolian',
      'no': 'Norwegian',
      'fa': 'Persian',
      'pl': 'Polish',
      'pt': 'Portuguese',
      'pa': 'Punjabi',
      'ro': 'Romanian',
      'ru': 'Russian',
      'sr': 'Serbian',
      'sk': 'Slovak',
      'sl': 'Slovenian',
      'es': 'Spanish',
      'sw': 'Swahili',
      'sv': 'Swedish',
      'tj': 'Tajik',
      'ta': 'Tamil',
      'te': 'Telugu',
      'th': 'Thai',
      'tr': 'Turkish',
      'tk': 'Turkmen',
      'uk': 'Ukrainian',
      'ur': 'Urdu',
      'uz': 'Uzbek',
      'vi': 'Vietnamese',
      'cy': 'Welsh',
      'xh': 'Xhosa',
      'zu': 'Zulu',
    };

    // Return the full name or null if not found
    return languageMap[shortName.toLowerCase()] ?? '';
  }

  static String? getCountryName(String shortName) {
    // Map of country short names to full names (sorted alphabetically by country name)
    const Map<String, String> countryMap = {
      'AF': 'Afghanistan',
      'AL': 'Albania',
      'DZ': 'Algeria',
      'AR': 'Argentina',
      'AU': 'Australia',
      'AT': 'Austria',
      'BD': 'Bangladesh',
      'BE': 'Belgium',
      'BR': 'Brazil',
      'CA': 'Canada',
      'CN': 'China',
      'CO': 'Colombia',
      'CZ': 'Czech Republic',
      'DK': 'Denmark',
      'EG': 'Egypt',
      'FI': 'Finland',
      'FR': 'France',
      'DE': 'Germany',
      'GR': 'Greece',
      'HK': 'Hong Kong',
      'HU': 'Hungary',
      'IN': 'India',
      'ID': 'Indonesia',
      'IR': 'Iran',
      'IQ': 'Iraq',
      'IE': 'Ireland',
      'IL': 'Israel',
      'IT': 'Italy',
      'JP': 'Japan',
      'JO': 'Jordan',
      'KZ': 'Kazakhstan',
      'KR': 'South Korea',
      'KW': 'Kuwait',
      'LB': 'Lebanon',
      'LY': 'Libya',
      'MY': 'Malaysia',
      'MX': 'Mexico',
      'MA': 'Morocco',
      'NL': 'Netherlands',
      'NZ': 'New Zealand',
      'NG': 'Nigeria',
      'NO': 'Norway',
      'PK': 'Pakistan',
      'PS': 'Palestine',
      'PH': 'Philippines',
      'PL': 'Poland',
      'PT': 'Portugal',
      'QA': 'Qatar',
      'RO': 'Romania',
      'RU': 'Russia',
      'SA': 'Saudi Arabia',
      'RS': 'Serbia',
      'SG': 'Singapore',
      'ZA': 'South Africa',
      'ES': 'Spain',
      'SE': 'Sweden',
      'CH': 'Switzerland',
      'SY': 'Syria',
      'TH': 'Thailand',
      'TN': 'Tunisia',
      'TR': 'Turkey',
      'UA': 'Ukraine',
      'AE': 'United Arab Emirates',
      'GB': 'United Kingdom',
      'US': 'United States',
      'VN': 'Vietnam',
      'YE': 'Yemen',
    };

    // Return the full name or null if not found
    return countryMap[shortName.toUpperCase()];
  }

  static String getCountryNames(List<String> shortNameCountries) {
    List<String> countryNames = [];
    for (var i = 0; i < shortNameCountries.length; i++) {
      if (getCountryName(shortNameCountries[i]) != null) {
        countryNames.add('${getCountryName(shortNameCountries[i])}');
      }
    }
    return countryNames.join(', ');
  }
}
