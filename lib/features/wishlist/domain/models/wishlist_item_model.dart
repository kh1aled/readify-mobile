class WishlistItemModel {
  const WishlistItemModel({
    required this.title,
    required this.author,
    required this.price,
    required this.coverUrl,
  });

  final String title;
  final String author;
  final double price;
  final String coverUrl;
}