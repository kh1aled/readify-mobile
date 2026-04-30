class ReviewModel {
  final int id;
  final int rating;
  final String comment;
  final String createdAt;
  final String userName;
  final String userImage;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.comment,
    required this.createdAt,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json["id"],
      comment: json['comment'],
      createdAt: json['createdAt'],
      rating: json['rating'],
      userName: json['userName'],
      userImage: json['userImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'userName': userName,
      'createdAt': createdAt,
      'userImage': userImage,
    };
  }
}
