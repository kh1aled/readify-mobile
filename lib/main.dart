import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Readify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Readify Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> featuredBooks = [
    {
      'title': 'My Book Cover',
      'subtitle': 'Secrets in a Silicon Valley Startup',
      'author': 'Echoes Of The Future\nBy Khaled Hamdy',
      'price': '10\$',
      'color': Color(0xFFE53935),
      'textColor': Colors.yellow,
    },
    {
      'title': 'The Loneliest Girl in the Universe',
      'author': 'Echoes Of The Future\nBy Khaled Hamdy',
      'price': '2100\$',
      'color': Color(0xFF1A237E),
      'textColor': Colors.white,
      'hasImage': true,
    },
    {
      'title': 'Fr...',
      'author': 'Echoes Of The Future\nBy Khaled O',
      'price': '90\$',
      'color': Color(0xFFFFF176),
      'textColor': Colors.black,
    },
  ];

  final List<Map<String, dynamic>> businessBooks = [
    {
      'title': 'Successful Business',
      'subtitle': 'Guide to Starting a Business',
      'author': 'Echoes Of The Future\nBy Khaled Hamdy',
      'color': Color(0xFFF57F17),
      'textColor': Colors.white,
      'bordered': false,
    },
    {
      'title': 'The Investing Bible',
      'subtitle': "Book's subtitle can go here",
      'author': 'Echoes Of The Future\nBy Khaled Hamdy',
      'color': Colors.white,
      'textColor': Color(0xFF1B5E20),
      'bordered': true,
    },
    {
      'title': 'The Business Universe',
      'subtitle': 'A step-by-step to me',
      'author': 'Echoes Of The Future\nBy Peter...',
      'color': Color(0xFF1565C0),
      'textColor': Colors.white,
      'bordered': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Search Bar
                      _buildSearchBar(),
                      const SizedBox(height: 24),
                      // Featured Books Section
                      _buildSectionHeader('Featured Books'),
                      const SizedBox(height: 12),
                      _buildFeaturedBooks(),
                      const SizedBox(height: 24),
                      // Business & Investing Section
                      _buildSectionHeader('Business & investing'),
                      const SizedBox(height: 12),
                      _buildBusinessBooks(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(Icons.search, color: Colors.grey[500], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your library...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xFF2E7D32),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Row(
          children: [
            Text(
              'See all',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            Icon(Icons.arrow_forward, size: 16, color: Colors.grey[600]),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedBooks() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: featuredBooks.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final book = featuredBooks[index];
          return _buildFeaturedBookCard(book);
        },
      ),
    );
  }

  Widget _buildFeaturedBookCard(Map<String, dynamic> book) {
    return SizedBox(
      width: 115,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Cover
          Container(
            height: 155,
            width: 115,
            decoration: BoxDecoration(
              color: book['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (book['title'] == 'My Book Cover') ...[
                  Text(
                    'MY\nBOOK\nCOVER',
                    style: TextStyle(
                      color: book['textColor'] as Color,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    book['subtitle'] ?? '',
                    style: TextStyle(
                      color: (book['textColor'] as Color).withOpacity(0.8),
                      fontSize: 7,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'My name here',
                    style: TextStyle(
                      color: book['textColor'] as Color,
                      fontSize: 9,
                    ),
                  ),
                ] else if (book['hasImage'] == true) ...[
                  const Spacer(),
                  Center(
                    child: Text(
                      book['title'] ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: book['textColor'] as Color,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const Spacer(),
                ] else ...[
                  Text(
                    book['title'] ?? '',
                    style: TextStyle(
                      color: book['textColor'] as Color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            book['author'] ?? '',
            style: const TextStyle(fontSize: 10, color: Colors.black87),
            maxLines: 2,
          ),
          const SizedBox(height: 2),
          Text(
            book['price'] ?? '',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessBooks() {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: businessBooks.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final book = businessBooks[index];
          return _buildBusinessBookCard(book);
        },
      ),
    );
  }

  Widget _buildBusinessBookCard(Map<String, dynamic> book) {
    final isBordered = book['bordered'] == true;
    return SizedBox(
      width: 115,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 155,
            width: 115,
            decoration: BoxDecoration(
              color: book['color'] as Color,
              borderRadius: BorderRadius.circular(8),
              border: isBordered
                  ? Border.all(color: const Color(0xFF2E7D32), width: 2)
                  : null,
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (book['title'] == 'Successful Business') ...[
                  const Icon(Icons.bar_chart, color: Colors.white, size: 28),
                  const SizedBox(height: 6),
                  Text(
                    book['title'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: book['textColor'] as Color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book['subtitle'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: (book['textColor'] as Color).withOpacity(0.85),
                      fontSize: 8,
                    ),
                  ),
                ] else if (book['title'] == 'The Investing Bible') ...[
                  Text(
                    'THE',
                    style: TextStyle(
                      color: book['textColor'] as Color,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'INVESTING\nBIBLE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: book['textColor'] as Color,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book['subtitle'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: (book['textColor'] as Color).withOpacity(0.7),
                      fontSize: 7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'AUTHOR NAME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: book['textColor'] as Color,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ] else ...[
                  Text(
                    'THE\nBUSINESS\nUNIVERSE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: book['textColor'] as Color,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    book['subtitle'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: (book['textColor'] as Color).withOpacity(0.8),
                      fontSize: 8,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            book['author'] ?? '',
            style: const TextStyle(fontSize: 10, color: Colors.black87),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home, 'label': 'HOME'},
      {'icon': Icons.menu_book_outlined, 'label': 'LIBRARY'},
      {'icon': Icons.bookmark_border, 'label': 'WISHLIST'},
      {'icon': Icons.store_outlined, 'label': 'SHOP'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: isSelected
                          ? const Color(0xFF2E7D32)
                          : Colors.grey[500],
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? const Color(0xFF2E7D32)
                            : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}