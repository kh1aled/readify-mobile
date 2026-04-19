import 'package:flutter/material.dart';

class HorizontalGenreList extends StatefulWidget {
  const HorizontalGenreList({super.key, required this.genres});

  final List<Map<String, String>> genres;

  @override
  State<HorizontalGenreList> createState() => _HorizontalGenreListState();
}

class _HorizontalGenreListState extends State<HorizontalGenreList> {
  int _selectedIndex = 0;

  // Map genre names to icons
  IconData _iconFor(String name) {
    switch (name.toLowerCase()) {
      case 'business':
        return Icons.work_outline_rounded;
      case 'technology':
        return Icons.memory_rounded;
      case 'fiction':
        return Icons.auto_stories_outlined;
      case 'non-fiction':
        return Icons.library_books_outlined;
      case 'science fiction':
        return Icons.rocket_launch_outlined;
      case 'fantasy':
        return Icons.auto_fix_high_outlined;
      case 'mystery':
        return Icons.search_outlined;
      case 'romance':
        return Icons.favorite_outline_rounded;
      case 'thriller':
        return Icons.bolt_outlined;
      case 'biography':
        return Icons.person_outline_rounded;
      case 'history':
        return Icons.history_edu_outlined;
      case 'self-help':
        return Icons.self_improvement_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final name = widget.genres[index]['name']!;
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? primary : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? primary : Colors.grey.shade300,
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _iconFor(name),
                    size: 16,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
