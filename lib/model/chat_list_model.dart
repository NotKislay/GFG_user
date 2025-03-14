import 'package:gofriendsgo/utils/constants/paths.dart';

class ChatModel {
  final String mainText;
  final String subText;
  final String imagePath;
  final String time;

  ChatModel(
      {required this.mainText,
      required this.subText,
      required this.imagePath,
      required this.time});
}

List<ChatModel> chatModelList = [
  ChatModel(
      mainText: 'Rail Booking',
      subText: 'Hey ! there I need a Train Tickets ',
      imagePath: AppImages.busIcon,
      time: '4 min'),
  ChatModel(
      mainText: 'Rail Booking',
      subText: 'Hey ! there I need a Train Tickets ',
      imagePath: AppImages.busIcon,
      time: '4 min'),
  ChatModel(
      mainText: 'Rail Booking',
      subText: 'Hey ! there I need a Train Tickets ',
      imagePath: AppImages.busIcon,
      time: '4 min'),
  ChatModel(
      mainText: 'Rail Booking',
      subText: 'Hey ! there I need a Train Tickets ',
      imagePath: AppImages.busIcon,
      time: '4 min'),
  ChatModel(
      mainText: 'Rail Booking',
      subText: 'Hey ! there I need a Train Tickets',
      imagePath: AppImages.busIcon,
      time: 'yesterday'),
  ChatModel(
      mainText: 'Rail Booking',
      subText: 'Hey ! there I need a Train Tickets ',
      imagePath: AppImages.busIcon,
      time: 'yesterday'),
];
