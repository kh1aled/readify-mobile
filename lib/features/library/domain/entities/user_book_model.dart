class UserBookModel {
  final int bookId;
  final String bookCover;
  final String bookTitle;
  final String bookAuthor;
  final String bookUrl;
  final double bookProgressPercentage;
  final bool isDownloaded;
  final String status;
  final DateTime? lastAccessed;

  const UserBookModel({
    required this.bookId,
    required this.bookCover,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookUrl,
    required this.bookProgressPercentage,
    required this.isDownloaded,
    required this.status,
    this.lastAccessed,
  });

  factory UserBookModel.fromJson(Map<String, dynamic> json) {
    return UserBookModel(
      bookId: (json['bookId'] as num?)?.toInt() ?? 0,
      bookCover: json['bookCover'] as String? ?? '',
      bookTitle: json['bookTitle'] as String? ?? 'Unknown Title',
      bookAuthor: json['bookAuthor'] as String? ?? 'Unknown Author',
      bookUrl: json['bookUrl'] as String? ?? '',
      bookProgressPercentage:
          (json['bookProgressPercentage'] as num?)?.toDouble() ?? 0.0,
      isDownloaded: json['isDownloaded'] as bool? ?? false,
      status: json['status'] as String? ?? 'Not Started',
      lastAccessed: json['lastAccessed'] != null
          ? DateTime.tryParse(json['lastAccessed'] as String)
          : null,
    );
  }

  UserBookModel copyWith({
    double? bookProgressPercentage,
    bool? isDownloaded,
    String? status,
    DateTime? lastAccessed,
  }) {
    return UserBookModel(
      bookId: bookId,
      bookCover: bookCover,
      bookTitle: bookTitle,
      bookAuthor: bookAuthor,
      bookUrl: bookUrl,
      bookProgressPercentage:
          bookProgressPercentage ?? this.bookProgressPercentage,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      status: status ?? this.status,
      lastAccessed: lastAccessed ?? this.lastAccessed,
    );
  }
}
