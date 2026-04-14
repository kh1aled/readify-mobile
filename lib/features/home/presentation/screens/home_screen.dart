import 'package:flutter/material.dart';
import 'package:readify_app/features/home/presentation/widgets/category_list.dart';
import 'package:readify_app/features/home/presentation/widgets/horizontal_book_list.dart';
import 'package:readify_app/shared/widgets/search_bar.dart';
import 'package:readify_app/features/home/presentation/widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ─── Featured Books ────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> featuredBooks = [
    {
      'title': 'Echoes of the Future',
      'author': 'Khaled Hamdy',
      'price': '\$10.99',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'The Last Horizon',
      'author': 'Amira Saleh',
      'price': '\$13.49',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Shades of Silence',
      'author': 'Omar Farouk',
      'price': '\$9.99',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Beyond the Dunes',
      'author': 'Nour El-Din',
      'price': '\$11.00',
      'coverUrl': 'assets/images/books/book6.png',
    },
    {
      'title': 'The Amber Sky',
      'author': 'Layla Hassan',
      'price': '\$14.99',
      'coverUrl': 'assets/images/books/book4.png',
    },
    {
      'title': 'Voices in the Wind',
      'author': 'Sara Mahmoud',
      'price': '\$8.49',
      'coverUrl': 'assets/images/books/book3.png',
    },
    {
      'title': 'A Map of Stars',
      'author': 'Youssef Karim',
      'price': '\$12.00',
      'coverUrl': 'assets/images/books/book2.png',
    },
  ];

  // ─── Recently Reduced eBooks ───────────────────────────────────────────────
  final List<Map<String, dynamic>> recentlyBooks = [
    {
      'title': 'The Quiet Storm',
      'author': 'Hana Ibrahim',
      'price': '\$4.99',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Desert Bloom',
      'author': 'Tarek Nasser',
      'price': '\$3.99',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Midnight in Cairo',
      'author': 'Dina Mostafa',
      'price': '\$5.49',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Salt and Shadow',
      'author': 'Rami Khalil',
      'price': '\$2.99',
      'coverUrl': 'assets/images/books/book6.png',
    },
    {
      'title': 'The Forgotten River',
      'author': 'Mona Adel',
      'price': '\$4.49',
      'coverUrl': 'assets/images/books/book4.png',
    },
    {
      'title': 'Glass and Gold',
      'author': 'Karim Sayed',
      'price': '\$3.49',
      'coverUrl': 'assets/images/books/book3.png',
    },
    {
      'title': 'Paper Lanterns',
      'author': 'Nadia Fouad',
      'price': '\$1.99',
      'coverUrl': 'assets/images/books/book2.png',
    },
  ];

  // ─── Top-Selling Books ─────────────────────────────────────────────────────
  final List<Map<String, dynamic>> topSellingBooks = [
    {
      'title': 'The Iron Meridian',
      'author': 'Samir El-Ghoul',
      'price': '\$15.99',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Children of the Nile',
      'author': 'Fatima Rashid',
      'price': '\$12.99',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Throne of Dust',
      'author': 'Hassan Al-Amin',
      'price': '\$14.00',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'The Ember Prophecy',
      'author': 'Lina Sharif',
      'price': '\$13.99',
      'coverUrl': 'assets/images/books/book6.png',
    },
    {
      'title': 'Seven Sands',
      'author': 'Adham Zaki',
      'price': '\$11.49',
      'coverUrl': 'assets/images/books/book4.png',
    },
    {
      'title': 'Oath of the Wanderer',
      'author': 'Rana Fathy',
      'price': '\$16.00',
      'coverUrl': 'assets/images/books/book3.png',
    },
    {
      'title': 'The Obsidian Gate',
      'author': 'Mahmoud Saad',
      'price': '\$17.99',
      'coverUrl': 'assets/images/books/book2.png',
    },
  ];

  // ─── Popular Free Books ────────────────────────────────────────────────────
  final List<Map<String, dynamic>> popularFreeBooks = [
    {
      'title': 'First Light',
      'author': 'Yasmine Nour',
      'price': 'Free',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'The Open Road',
      'author': 'Bilal Hakim',
      'price': 'Free',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Whispers at Dusk',
      'author': 'Salma Hany',
      'price': 'Free',
      'coverUrl': 'assets/images/books/book1.png',
    },
    {
      'title': 'Letters to No One',
      'author': 'Tamer Gouda',
      'price': 'Free',
      'coverUrl': 'assets/images/books/book6.png',
    },
    {
      'title': 'The Silver Thread',
      'author': 'Aya Morsi',
      'price': 'Free',
      'coverUrl': 'assets/images/books/book4.png',
    },
    {
      'title': 'Edge of Tomorrow',
      'author': 'Khaled Anwar',
      'price': 'Free',
      'coverUrl': 'assets/images/books/book3.png',
    },
    {
      'title': 'A Thousand Skies',
      'author': 'Mariam Essam',
      'price': 'Free',
      'coverUrl': 'assets/images/books/book2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    const SearchBarWidget(),
                    const SizedBox(height: 25.0),
                    const SectionHeader(title: 'Featured Books'),
                    HorizontalBookList(books: featuredBooks),
                    const SizedBox(height: 16.0),
                    const SectionHeader(title: 'Recently Reduced eBooks'),
                    HorizontalBookList(books: recentlyBooks),
                    const SizedBox(height: 16.0),
                    const SectionHeader(title: 'Top-Selling Books'),
                    HorizontalBookList(books: topSellingBooks),
                    const SizedBox(height: 16.0),
                    const SectionHeader(title: 'Popular Free Books'),
                    HorizontalBookList(books: popularFreeBooks),
                    const SizedBox(height: 24.0),
                    const SectionHeader(title: 'Explore Play Books'),
                    CategoryList(),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
