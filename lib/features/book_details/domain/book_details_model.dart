import 'package:readify_app/features/book_details/domain/review_model.dart';

class BookDetailsModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String addedDate;
  final String? updatedDate;
  final String authorName;
  final String genreName;
  final String publisherName;
  final String coverUrl;
  final String fileUrl;
  final double rating;
  final int pagesCount;
  final List<ReviewModel> reviews;

  BookDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.addedDate,
    this.updatedDate,
    required this.authorName,
    required this.genreName,
    required this.publisherName,
    required this.coverUrl,
    required this.fileUrl,
    required this.rating,
    required this.pagesCount,
    required this.reviews,
  });

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      addedDate: json['addedDate'] ?? '',
      updatedDate: json['updatedDate'],

      authorName: json['authorName'] ?? '',
      genreName: json['genreName'] ?? '',
      publisherName: json['publisherName'] ?? '',

      coverUrl: json['coverUrl'] ?? '',
      fileUrl: json['fileUrl'] ?? '',

      rating: (json['rating'] ?? 0).toDouble(),
      pagesCount: json['pagesCount'] ?? 0,

      reviews:
          (json['reviews'] as List?)
              ?.map((e) => ReviewModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'addedDate': addedDate,
      'updatedDate': updatedDate,
      'authorName': authorName,
      'genreName': genreName,
      'publisherName': publisherName,
      'coverUrl': coverUrl,
      'fileUrl': fileUrl,
      'rating': rating,
      'pagesCount': pagesCount,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}
