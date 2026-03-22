class OnBoardingModel {
  final String imagePath;
  final String title;
  final String subTitle;
  OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      imagePath: "assets/images/on_boarding_1.png",
      title: "Discover Amazing Destinations",
      subTitle:
          "Explore handpicked travel packages and destinations curated just for you. From serene beaches to adventurous mountains, find your perfect getaway with GoFriendsGo."),
  OnBoardingModel(
      imagePath: "assets/images/on_boarding_2.png",
      title: "Easy Booking & Management",
      subTitle:
          "Book your dream vacation in just a few taps. Manage your bookings, track your trips, and access all your travel details anytime, anywhere with our easy-to-use app."),
  OnBoardingModel(
      imagePath: "assets/images/on_boarding_3.png",
      title: "24/7 Travel Support",
      subTitle:
          "Chat with our travel experts anytime you need help. Get instant support, travel tips, and personalized recommendations to make your journey unforgettable."),
  OnBoardingModel(
      imagePath: "assets/images/on_boarding_4.png",
      title: "Start Your Journey Today",
      subTitle:
          "Join thousands of happy travelers who trust GoFriendsGo for their adventures. Create your account now and unlock exclusive travel deals and experiences."),
];
