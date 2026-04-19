import 'package:flutter/material.dart';

class BookEntity {
  final String id;
  final String title;
  final String author;
  final Color coverColor;
  final Color textColor;
  final double rating;
  final int reviewCount;
  final int pages;
  final String publishDate;
  final String genre;
  final double price;
  final double? originalPrice;
  final String? description;
  final String? publisher;
  final String? isbn;
  final String? language;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.coverColor,
    this.textColor = Colors.white,
    required this.rating,
    required this.reviewCount,
    required this.pages,
    required this.publishDate,
    required this.genre,
    required this.price,
    this.originalPrice,
    this.description,
    this.publisher,
    this.isbn,
    this.language,
  });

  int get discountPercent {
    if (originalPrice == null) return 0;
    return ((1 - price / originalPrice!) * 100).round();
  }

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  String get formattedReviewCount {
    if (reviewCount >= 1000) {
      return '${(reviewCount / 1000).toStringAsFixed(1)}k';
    }
    return reviewCount.toString();
  }
}

class ReviewEntity {
  final String id;
  final String name;
  final String initials;
  final int stars;
  final String comment;
  final String date;
  final Color avatarColor;

  const ReviewEntity({
    required this.id,
    required this.name,
    required this.initials,
    required this.stars,
    required this.comment,
    required this.date,
    required this.avatarColor,
  });
}

class NavItemEntity {
  final dynamic icon; // IconData
  final String label;

  const NavItemEntity({required this.icon, required this.label});
}
