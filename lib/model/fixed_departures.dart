class FixedDepartures {
  final bool isDepartureFixed;
  final String title;
  final int rating;
  final String date;
  final String locations;
  final List<String> packageDetails;
  final String amount;

  FixedDepartures(
      {required this.isDepartureFixed,
      required this.title,
      required this.rating,
      required this.date,
      required this.locations,
      required this.packageDetails,
      required this.amount});
}

final List<FixedDepartures> fixedDeparturesList = [
  FixedDepartures(
      isDepartureFixed: true,
      title:
          "6N Mauritius Fixed Departure - Anelia Resort &Spa (4 Star ) (Ex-Mumbai )",
      rating: 4,
      date: "12th May - 22nd Sep 2024",
      locations: "BOM - MUR - BOM",
      packageDetails: [
        "Hotel - Anelia Resort & Spa Mauritius (Superior Room)",
        "Full Day lle Aux Cerf Tour withSpeedboat",
        "Full Day North Tour",
        "Full Day South Tour",
        "Breakfast & Lunch / Dinner Included",
        "Airport Transfers- SIC"
      ],
      amount: "85,000"),
  FixedDepartures(
      isDepartureFixed: false,
      title: "4N Thailand Fixed Departure - Every Saturday",
      rating: 4,
      date: "12th May - 22nd Sep 2024",
      locations: "Flight not included",
      packageDetails: [
        "Hotel - Anelia Resort & Spa Mauritius (Superior Room)",
        "Full Day lle Aux Cerf Tour withSpeedboat",
        "Full Day North Tour",
        "Full Day South Tour",
        "Breakfast & Lunch / Dinner Included",
        "Airport Transfers- SIC"
      ],
      amount: "12,000")
];
