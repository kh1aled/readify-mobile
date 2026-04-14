import 'package:flutter/material.dart';
import 'package:readify_app/features/home/presentation/widgets/category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {'title': 'Fiction', 'icon': Icons.auto_stories},
    {'title': 'Science', 'icon': Icons.science_outlined},
    {'title': 'History', 'icon': Icons.account_balance},
    {'title': 'Romance', 'icon': Icons.favorite_outline},
    {'title': 'Mystery', 'icon': Icons.search_outlined},
    {'title': 'Self-Help', 'icon': Icons.self_improvement},
    {'title': 'Technology', 'icon': Icons.computer_outlined},
    {'title': 'Children', 'icon': Icons.child_care_outlined},
    {'title': 'Biography', 'icon': Icons.person_outline},
    {'title': 'Top Selling', 'icon': Icons.trending_up},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        itemCount: _categories.length,
        itemBuilder: (_, index) {
          final cat = _categories[index];
          return CategoryCard(
            title: cat['title'],
            icon: cat['icon'],
            onTap: () {
              // TODO: navigate to category
            },
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 10),
      ),
    );
  }
}
