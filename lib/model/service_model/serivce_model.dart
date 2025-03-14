class ServiceModel {
  final int id;
  final String name;
  final String image;
  final int status;

  ServiceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
    );
  }
}
