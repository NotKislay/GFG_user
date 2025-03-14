class CarouselsModel {
  final bool status;
  final String message;
  final List<Carousel> data;

  CarouselsModel(
      {required this.status, required this.message, required this.data});

  factory CarouselsModel.fromJson(Map<String, dynamic> json) {
    return CarouselsModel(
      status: json['status'],
      message: json['message'],
      data: List<Carousel>.from(json['data']['carousels']
          .map((carousel) => Carousel.fromJson(carousel))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'carousels': data.map((carousel) => carousel.toJson()).toList(),
      },
    };
  }
}

class Carousel {
  final int id;
  final String image;
  final String title;
  final String description;
  final String offers;
  final String link;

  Carousel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.offers,
    required this.link
  });

  factory Carousel.fromJson(Map<String, dynamic> json) {
    return Carousel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      offers: json['offers'],
      link: json['link']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'offers': offers,
      'link': link
    };
  }
}
