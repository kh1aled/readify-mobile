import 'package:flutter/material.dart';
import 'package:readify_app/features/home/presentation/widgets/category_list.dart';
import 'package:readify_app/features/shop/presentation/widgets/featured_banner.dart';
import 'package:readify_app/features/shop/presentation/widgets/horizontal_genre_list.dart';
import 'package:readify_app/features/shop/presentation/widgets/shop_book_row.dart';
import 'package:readify_app/features/shop/presentation/widgets/shop_section.dart';
import 'package:readify_app/shared/widgets/search_bar.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<Map<String, String>> genresList = [
    {'name': 'Fiction'},
    {'name': 'Non-Fiction'},
    {'name': 'Science Fiction'},
    {'name': 'Fantasy'},
    {'name': 'Mystery'},
    {'name': 'Romance'},
    {'name': 'Thriller'},
    {'name': 'Biography'},
    {'name': 'History'},
    {'name': 'Self-Help'},
  ];

  final List<Map<String, dynamic>> featuredBooks = [
    {'title': 'Echoes of the Future','author': 'Khaled Hamdy','price': '\$10.99','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'The Last Horizon','author': 'Amira Saleh','price': '\$13.49','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Shades of Silence','author': 'Omar Farouk','price': '\$9.99','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Beyond the Dunes','author': 'Nour El-Din','price': '\$11.00','coverUrl': 'assets/images/books/book6.png'},
    {'title': 'The Amber Sky','author': 'Layla Hassan','price': '\$14.99','coverUrl': 'assets/images/books/book4.png'},
  ];

  final List<Map<String, dynamic>> recentlyBooks = [
    {'title': 'The Quiet Storm','author': 'Hana Ibrahim','price': '\$4.99','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Desert Bloom','author': 'Tarek Nasser','price': '\$3.99','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Midnight in Cairo','author': 'Dina Mostafa','price': '\$5.49','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Salt and Shadow','author': 'Rami Khalil','price': '\$2.99','coverUrl': 'assets/images/books/book6.png'},
    {'title': 'The Forgotten River','author': 'Mona Adel','price': '\$4.49','coverUrl': 'assets/images/books/book4.png'},
    {'title': 'Glass and Gold','author': 'Karim Sayed','price': '\$3.49','coverUrl': 'assets/images/books/book3.png'},
    {'title': 'Paper Lanterns','author': 'Nadia Fouad','price': '\$1.99','coverUrl': 'assets/images/books/book2.png'},
  ];

  final List<Map<String, dynamic>> topSellingBooks = [
    {'title': 'The Iron Meridian','author': 'Samir El-Ghoul','price': '\$15.99','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Children of the Nile','author': 'Fatima Rashid','price': '\$12.99','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Throne of Dust','author': 'Hassan Al-Amin','price': '\$14.00','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'The Ember Prophecy','author': 'Lina Sharif','price': '\$13.99','coverUrl': 'assets/images/books/book6.png'},
    {'title': 'Seven Sands','author': 'Adham Zaki','price': '\$11.49','coverUrl': 'assets/images/books/book4.png'},
    {'title': 'Oath of the Wanderer','author': 'Rana Fathy','price': '\$16.00','coverUrl': 'assets/images/books/book3.png'},
    {'title': 'The Obsidian Gate','author': 'Mahmoud Saad','price': '\$17.99','coverUrl': 'assets/images/books/book2.png'},
  ];

  final List<Map<String, dynamic>> popularFreeBooks = [
    {'title': 'First Light','author': 'Yasmine Nour','price': 'Free','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'The Open Road','author': 'Bilal Hakim','price': 'Free','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Whispers at Dusk','author': 'Salma Hany','price': 'Free','coverUrl': 'assets/images/books/book1.png'},
    {'title': 'Letters to No One','author': 'Tamer Gouda','price': 'Free','coverUrl': 'assets/images/books/book6.png'},
    {'title': 'The Silver Thread','author': 'Aya Morsi','price': 'Free','coverUrl': 'assets/images/books/book4.png'},
    {'title': 'A Thousand Skies','author': 'Mariam Essam','price': 'Free','coverUrl': 'assets/images/books/book2.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const SearchBarWidget(),
              const SizedBox(height: 20),

              // ── Genres ──────────────────────────────────────
              const Text(
                'Genres',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1C1C1E),
                ),
              ),
              const SizedBox(height: 12),
              HorizontalGenreList(genres: genresList),
              const SizedBox(height: 20),

              // ── Featured Banner ──────────────────────────────
              FeaturedBanner(books: featuredBooks),
              const SizedBox(height: 20),

              // ── Recently Reduced ─────────────────────────────
              ShopSection(
                title: 'Recently Reduced eBooks',
                onSeeAll: () {},
                child: ShopBookRow(books: recentlyBooks),
              ),
              const SizedBox(height: 20),

              // ── Top Selling ──────────────────────────────────
              ShopSection(
                title: 'Top-Selling Books',
                onSeeAll: () {},
                child: ShopBookRow(books: topSellingBooks),
              ),
              const SizedBox(height: 20),

              // ── Popular Free ─────────────────────────────────
              ShopSection(
                title: 'Popular Free Books',
                onSeeAll: () {},
                child: ShopBookRow(books: popularFreeBooks),
              ),
              const SizedBox(height: 20),

              // ── Explore ──────────────────────────────────────
              ShopSection(
                title: 'Explore Play Books',
                onSeeAll: () {},
                child: CategoryList(),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}