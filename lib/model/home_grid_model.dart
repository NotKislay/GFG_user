import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class HomeGrid {
  final String imagePath;
  final String titleText;
  final String subText;

  HomeGrid(
      {required this.imagePath,
      required this.titleText,
      required this.subText});
}

List<HomeGrid> homeGridItems = [
  HomeGrid(
      imagePath: 'assets/images/fixed_dep.png',
      titleText: 'Fixed Departure',
      subText: /* TextStrings.homeGridFirstSubText */ ''),
  HomeGrid(
      imagePath: 'assets/images/passport_check.png',
      titleText: 'Passport checklist',
      subText: /* TextStrings.homeGridSecondSubText */ ''),
  HomeGrid(
      imagePath: 'assets/images/visa.jpg',
      titleText: 'Visa checklist',
      subText: /* TextStrings.homeGridThirdSubText */ ''),
  HomeGrid(
      imagePath: 'assets/images/cab_rates.jpg',
      titleText: 'Cab rates',
      subText: /* TextStrings.homeGridFourthText */ ''),
];
