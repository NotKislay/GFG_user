class NotificationCardModel {
  final String mainText;
  final String timeText;
  final String imageIcon;
  final String subText;
  bool isUnread;

  NotificationCardModel(
      {required this.mainText,
      required this.isUnread,
      required this.timeText,
      required this.imageIcon,
      required this.subText});
}

List<NotificationCardModel> notificationCardList = [
  NotificationCardModel(
    isUnread: true,
      mainText: 'Lorem ipsum dolor sit amet, consectetur ',
      timeText: '1m ago.',
      imageIcon: 'assets/images/Hotel icon.png',
      subText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.  '),
  NotificationCardModel(
    isUnread: false,
      mainText: 'Lorem ipsum dolor sit amet, consectetur ',
      timeText: '1m ago.',
      imageIcon: 'assets/images/Hotel icon.png',
      subText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.  '),
  NotificationCardModel(
    isUnread: false,
      mainText: 'Lorem ipsum dolor sit amet, consectetur ',
      timeText: '1m ago.',
      imageIcon: 'assets/images/Hotel icon.png',
      subText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.  '),
  NotificationCardModel(
    isUnread: true,
      mainText: 'Lorem ipsum dolor sit amet, consectetur ',
      timeText: '1m ago.',
      imageIcon: 'assets/images/Hotel icon.png',
      subText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.  '),
 
];
