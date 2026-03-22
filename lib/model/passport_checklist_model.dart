class PassportChecklistModel {
  final String heading;
  final List<String> details;

  PassportChecklistModel({required this.heading, required this.details});
}

List<PassportChecklistModel> passportChecklistModelList = [
  PassportChecklistModel(heading: "Adult", details: [
    "Adhar card should be here on the passport form and signed across and the second photograph should be attacheed with a gem clip",
        "From the applicant stating his name, designation, passport number and purpose& duration of stay in brie. The letter should be duly signed by the applicant and addressed to the visa officer.",
    "From the applicant stating his name, designation, passport number and purpose duration of stay in brief.",
    "Higher Qualification with Matric certificate , (Single \\ Married)",
        "Please Note: Photographs should not be more than 3 months Old scanned / stapled and should not be used in any of the previous passport."
  ]),
  PassportChecklistModel(heading: "Infant / Child", details: [
    "Adhar card should be here on the passport form and signed across and the second photograph should be attacheed with a gem clip",
        "From the applicant stating his name, designation, passport number and purpose& duration of stay in brie. The letter should be duly signed by the applicant and addressed to the visa officer.",
    "From the applicant stating his name, designation, passport number and purpose duration of stay in brief.",
    "Higher Qualification with Matric certificate , (Single \\ Married)",
        "Please Note: Photographs should not be more than 3 months Old scanned / stapled and should not be used in any of the previous passport."
  ])
];
