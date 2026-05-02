class WishlistItemModel {
  const WishlistItemModel({
    required this.bookId,
    required this.title,
    required this.author,
    required this.price,
    required this.coverUrl,
  });

  final int bookId;
  final String title;
  final String author;
  final double price;
  final String coverUrl;

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      bookId: json['bookId'] as int,
      title: json['bookTitle'] as String,
      author: json['authorName'] as String,
      price: (json['price'] as num).toDouble(),
      coverUrl: json['bookCoverUrl'] as String,
    );
  }
}