class BookModel {
  const BookModel({
    required this.title,
    required this.author,
    required this.progressPercent,
    required this.coverUrl,
  });

  final String title;
  final String author;
  final int progressPercent;
  final String coverUrl;
}