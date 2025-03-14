class BookingCard {
  final String mainText;
  final String bookingAmount;
  final String bookingName;
  final String bookingDate;
  final String bookingType;

  BookingCard(
      {required this.mainText,
      required this.bookingAmount,
      required this.bookingName,
      required this.bookingDate,
      required this.bookingType});
}

List<BookingCard> bookingCardList = [
  BookingCard(
      mainText: 'The Lalit Great Eastern Kolkata',
      bookingAmount: '₹ 5,568',
      bookingName: 'Mr Aigha Kunha',
      bookingDate: '02-May-2024',
      bookingType: 'Hotel Booking'),
  BookingCard(
      mainText: 'The Lalit Great Eastern Kolkata',
      bookingAmount: '₹ 5,568',
      bookingName: 'Mr Aigha Kunha',
      bookingDate: '02-May-2024',
      bookingType: 'Hotel Booking'),
  BookingCard(
      mainText: 'The Lalit Great Eastern Kolkata',
      bookingAmount: '₹ 5,568',
      bookingName: 'Mr Aigha Kunha',
      bookingDate: '02-May-2024',
      bookingType: 'Hotel Booking'),
];
