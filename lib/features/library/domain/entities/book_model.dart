/// Legacy BookModel kept for backward compatibility.
/// For library books fetched from the API, use [UserBookModel] instead.
///
/// See: package:readify_app/features/library/domain/entities/user_book_model.dart
@Deprecated('Use UserBookModel from the library feature for API-backed books.')
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
