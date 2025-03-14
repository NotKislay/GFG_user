class CabRatesModel {
  final String location;
  final Map<String, String> vehicleAndAmount;
  final String extraNote;

  CabRatesModel(
      {required this.location,
      required this.vehicleAndAmount,
      required this.extraNote});
}

List<CabRatesModel> cabRatesModelList = [
  CabRatesModel(
      location: "OUT OF TOWN",
      vehicleAndAmount: {
        "SWIFT DZIRE/SIMILAR": "12 Rs/KM",
        "SCORPIO/ERTIGA/SIMILAR": "15 Rs/KM",
        "INNOVA/SIMILAR": "16 Rs/KM",
        "INNOVA CRYSTA/SIMILAR": "19 Rs/KM"
      },
      extraNote:
          "NOTE - MINIMUM 200 KM CHARGE FOR ONE DAY , TOLL PARKING AND NIGHT CHARGE EXTRA"),
          
          
           CabRatesModel(
      location: "LOCAL PATNA",
      vehicleAndAmount: {
        "SWIFT DZIRE/SIMILAR": "Rs 1200 RENT + FUEL 10 KM/ L MILEAGE",
        "SCORPIO/ERTIGA/SIMILAR": "Rs 1200 RENT + FUEL 10 KM/ L MILEAGE",
        "INNOVA/SIMILAR": "Rs 1200 RENT + FUEL 10 KM/ L MILEAGE",
        "INNOVA CRYSTA/SIMILAR": "Rs 1200 RENT + FUEL 10 KM/ L MILEAGE"
      },
      extraNote:
          "NOTE - MINIMUM 200 KM CHARGE FOR ONE DAY , TOLL PARKING AND NIGHT CHARGE EXTRA")
];
