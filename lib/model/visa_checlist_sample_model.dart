class VisaCheckListCategoriesModel {
  final String imageUrl;
  final String countryName;

  VisaCheckListCategoriesModel(
      {required this.imageUrl, required this.countryName});
}

List<VisaCheckListCategoriesModel> visaCheckListCategoriesModelList = [
  VisaCheckListCategoriesModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq7VG3RaJRr28VwS0HWgNZAgnDTnH9UYDLUg&s",
      countryName: "Singapore"),
  VisaCheckListCategoriesModel(
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Halong_bay_vietnam.JPG/1200px-Halong_bay_vietnam.JPG",
      countryName: "Viatnam"),
  VisaCheckListCategoriesModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7UlM36Gijmnl0Yy9Vl_qKuJxkplcRD4U4og&s",
      countryName: "Malaysia"),
  VisaCheckListCategoriesModel(
      imageUrl:
          "https://cdn.britannica.com/43/134743-050-D0625A44/train-first-Dubai-emirate-rapid-transit-line-kind-Sept-10-2009.jpg",
      countryName: "Dubai"),
];
