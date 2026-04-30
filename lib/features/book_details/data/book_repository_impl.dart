import 'package:flutter/material.dart';
import 'package:readify_app/features/book_details/data/book_remote_data_source.dart';
import 'package:readify_app/features/book_details/domain/book_details_model.dart';
import 'package:readify_app/features/book_details/domain/book_repository.dart';
import '../domain/entities.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl._();
  static final BookRepositoryImpl instance = BookRepositoryImpl._();

  // ── Main Book ──────────────────────────────────────────────────────────────

  BookEntity get mainBook => const BookEntity(
    id: '1',
    title: 'The Last Data Scientist',
    author: 'Sophia Bennett',
    coverColor: Color(0xFFE8574A),
    rating: 4.6,
    reviewCount: 170,
    pages: 210,
    publishDate: '14 December 2022',
    genre: 'Sci-Fi / Thriller',
    price: 10.0,
    originalPrice: 9.6,
    publisher: 'DataPress Publishing',
    isbn: '978-1-234-56789-0',
    language: 'English',
    description:
        'In a world driven by data, a young programmer discovers an algorithm capable of predicting human behavior with terrifying accuracy. As powerful organizations race to control it, he must decide whether to protect the future or rewrite it.',
  );

  Future<BookDetailsModel> fetchBookDetails(int bookId) async {
    return BookRemoteDataSource().fetchBookDetails(bookId);
  }

  // ── Reviews ────────────────────────────────────────────────────────────────

  List<ReviewEntity> get reviews => const [
    ReviewEntity(
      id: 'r1',
      name: 'Sarah M.',
      initials: 'SM',
      stars: 5,
      comment:
          'A gripping, thought-provoking thriller. I couldn\'t put it down. Sophia Bennett has crafted something truly special.',
      date: '3 days ago',
      avatarColor: Color(0xFF6C63FF),
    ),
    ReviewEntity(
      id: 'r2',
      name: 'James O.',
      initials: 'JO',
      stars: 4,
      comment:
          'Great concept and execution. The pacing is excellent and the ethical dilemmas feel very real and relevant.',
      date: '1 week ago',
      avatarColor: Color(0xFF43B89C),
    ),
    ReviewEntity(
      id: 'r3',
      name: 'Priya S.',
      initials: 'PS',
      stars: 5,
      comment:
          'This book changed how I see data and privacy. A must read for anyone in tech.',
      date: '2 weeks ago',
      avatarColor: Color(0xFFE8A838),
    ),
  ];

  // ── More by Author ─────────────────────────────────────────────────────────

  List<BookEntity> get moreByAuthor => const [
    BookEntity(
      id: '2',
      title: 'The Algorithm Queen',
      author: 'Sophia Bennett',
      coverColor: Color(0xFF2D6A4F),
      rating: 4.4,
      reviewCount: 3200,
      pages: 280,
      publishDate: '2021',
      genre: 'Thriller',
      price: 9.99,
    ),
    BookEntity(
      id: '3',
      title: 'Data Ghost',
      author: 'Sophia Bennett',
      coverColor: Color(0xFF3D405B),
      rating: 4.2,
      reviewCount: 2100,
      pages: 310,
      publishDate: '2020',
      genre: 'Mystery',
      price: 8.99,
    ),
    BookEntity(
      id: '4',
      title: 'Neural Shadows',
      author: 'Sophia Bennett',
      coverColor: Color(0xFF5C4033),
      rating: 4.5,
      reviewCount: 4400,
      pages: 265,
      publishDate: '2019',
      genre: 'Sci-Fi',
      price: 11.99,
    ),
  ];

  // ── Similar Books ──────────────────────────────────────────────────────────

  List<BookEntity> get similarBooks => const [
    BookEntity(
      id: '5',
      title: 'The Code Breaker',
      author: 'Lena Marsh',
      coverColor: Color(0xFF1A3A4A),
      rating: 4.6,
      reviewCount: 8100,
      pages: 345,
      publishDate: '2022',
      genre: 'Thriller',
      price: 12.99,
    ),
    BookEntity(
      id: '6',
      title: 'Predictive Minds',
      author: 'Marcus Cole',
      coverColor: Color(0xFF4A1942),
      rating: 4.3,
      reviewCount: 5700,
      pages: 290,
      publishDate: '2021',
      genre: 'Sci-Fi',
      price: 10.49,
    ),
    BookEntity(
      id: '7',
      title: 'Silent Network',
      author: 'Ana Rivera',
      coverColor: Color(0xFF7B3F00),
      rating: 4.7,
      reviewCount: 9200,
      pages: 400,
      publishDate: '2023',
      genre: 'Thriller',
      price: 13.99,
    ),
  ];

  // ── Featured ───────────────────────────────────────────────────────────────

  List<BookEntity> get featuredBooks => const [
    BookEntity(
      id: '8',
      title: 'Quantum Hearts',
      author: 'Eve Hollis',
      coverColor: Color(0xFF0D3B66),
      rating: 4.8,
      reviewCount: 12000,
      pages: 380,
      publishDate: '2023',
      genre: 'Romance',
      price: 14.99,
    ),
    BookEntity(
      id: '9',
      title: 'The Mirror Code',
      author: 'Ray Usman',
      coverColor: Color(0xFF2C3E50),
      rating: 4.5,
      reviewCount: 7600,
      pages: 310,
      publishDate: '2022',
      genre: 'Mystery',
      price: 11.99,
    ),
    BookEntity(
      id: '10',
      title: 'Fracture Point',
      author: 'Nadia Klein',
      coverColor: Color(0xFF6C3483),
      rating: 4.4,
      reviewCount: 5300,
      pages: 270,
      publishDate: '2022',
      genre: 'Thriller',
      price: 10.99,
    ),
  ];

  // ── Recently Reduced ───────────────────────────────────────────────────────

  List<BookEntity> get recentlyReduced => const [
    BookEntity(
      id: '11',
      title: 'Pachinko',
      author: 'Min Jin Lee',
      coverColor: Color(0xFF1A3A4A),
      rating: 4.8,
      reviewCount: 18400,
      pages: 496,
      publishDate: '2017',
      genre: 'Historical Fiction',
      price: 7.99,
      originalPrice: 15.99,
    ),
    BookEntity(
      id: '12',
      title: 'Normal People',
      author: 'Sally Rooney',
      coverColor: Color(0xFF3C1518),
      rating: 4.3,
      reviewCount: 13700,
      pages: 273,
      publishDate: '2018',
      genre: 'Romance',
      price: 6.99,
      originalPrice: 12.99,
    ),
    BookEntity(
      id: '13',
      title: 'Educated',
      author: 'Tara Westover',
      coverColor: Color(0xFF2B4141),
      rating: 4.7,
      reviewCount: 21000,
      pages: 352,
      publishDate: '2018',
      genre: 'Memoir',
      price: 8.49,
      originalPrice: 14.99,
    ),
  ];
}
