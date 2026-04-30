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
  final int PagesCount;

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
    required this.PagesCount,
  });

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      addedDate: json['addedDate'] as String,
      updatedDate: json['updatedDate'] as String?,
      authorName: json['authorName'] as String,
      genreName: json['genreName'] as String,
      publisherName: json['publisherName'] as String,
      coverUrl: json['coverUrl'] as String,
      fileUrl: json['fileUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      PagesCount: json['pagesCount'] as int,
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
      'pagesCount': PagesCount,
    };
  }
}
