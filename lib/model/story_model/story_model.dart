class StoriesModel {
  final bool status;
  final String message;
  final StoriesData data;

  StoriesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StoriesModel.fromJson(Map<String, dynamic> json) {
    return StoriesModel(
      status: json['status'],
      message: json['message'],
      data: StoriesData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class StoriesData {
  final List<Story> stories;

  StoriesData({required this.stories});

  factory StoriesData.fromJson(Map<String, dynamic> json) {
    return StoriesData(
      stories: List<Story>.from(
          json['stories'].map((story) => Story.fromJson(story))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stories': stories.map((story) => story.toJson()).toList(),
    };
  }
}

class Story {
  final int id;
  final String image;
  final String type;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  Story({
    required this.id,
    required this.image,
    required this.type,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      image: json['image'],
      type: json['type'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'type': type,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
