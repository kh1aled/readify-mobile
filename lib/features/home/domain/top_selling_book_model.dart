class TopSellingBookModel {
  final int id;
  final String title;
  final double price;
  final String coverUrl;
  final double rating;
  final String authorFirstName;
  final String authorLastName;
  final int totalSold;

  TopSellingBookModel({
    required this.id,
    required this.title,
    required this.price,
    required this.coverUrl,
    required this.rating,
    required this.authorFirstName,
    required this.authorLastName,
    required this.totalSold,
  });

  factory TopSellingBookModel.fromJson(Map<String, dynamic> json) {
    return TopSellingBookModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'Unknown Title',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      coverUrl: json['coverUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      authorFirstName: json['authorFirstName'] as String? ?? '',
      authorLastName: json['authorLastName'] as String? ?? '',
      totalSold: (json['totalSold'] as num?)?.toInt() ?? 0,
    );
  }
}