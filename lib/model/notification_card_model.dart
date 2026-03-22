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
      mainText: 'Your booking has been confirmed!',
      timeText: '1m ago.',
      imageIcon: 'assets/images/Hotel icon.png',
      subText:
          'Great news! Your travel package booking has been successfully confirmed. Check your booking details for more information.'),
  NotificationCardModel(
    isUnread: false,
      mainText: 'Special offer on beach packages',
      timeText: '2h ago.',
      imageIcon: 'assets/images/Hotel icon.png',
      subText:
          'Limited time offer! Get up to 30% off on selected beach destinations. Book now and save on your next vacation.'),
  NotificationCardModel(
    isUnread: false,
      mainText: 'Reminder: Upcoming trip next week',
      timeText: '1d ago.',
      imageIcon: 'assets/images/Hotel icon.png',
      subText:
          'Your trip to your selected destination is coming up soon. Make sure you have all necessary documents ready.'),
  NotificationCardModel(
    isUnread: true,
      mainText: 'New message from travel expert',
      timeText: '3h ago.',
      imageIcon: 'assets/images/Hotel icon.png',
      subText:
          'You have a new message from our travel expert regarding your inquiry. Tap to view and respond.'),
 
];
