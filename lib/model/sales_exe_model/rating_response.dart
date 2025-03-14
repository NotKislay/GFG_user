class RatingResponse {
  final String rateeId;
  final double averageRating;
  final int totalRatings;
  final List<Rating> ratings;

  RatingResponse({
    required this.rateeId,
    required this.averageRating,
    required this.totalRatings,
    required this.ratings,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      rateeId: json['ratee_id'],
      averageRating: (json['average_rating'] as num).toDouble(),
      totalRatings: json['total_ratings'],
      ratings: List<Rating>.from(
        json['ratings'].map((rating) => Rating.fromJson(rating)),
      ),
    );
  }
}

class Rating {
  final int id;
  final int raterId;
  final int rateeId;
  final double rating;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? review;

  Rating({
    required this.id,
    required this.raterId,
    required this.rateeId,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    this.review,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'],
      raterId: json['rater_id'],
      rateeId: json['ratee_id'],
      rating: double.parse(json['rating']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      review: json['review'],
    );
  }
}
