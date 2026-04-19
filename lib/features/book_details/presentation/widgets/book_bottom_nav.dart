import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/domain/entities.dart';

class BookBottomNavBar extends StatefulWidget {
  const BookBottomNavBar({super.key});

  @override
  State<BookBottomNavBar> createState() => _BookBottomNavBarState();
}

class _BookBottomNavBarState extends State<BookBottomNavBar> {
  int _selected = 0;

  static const List<NavItemEntity> _items = [
    NavItemEntity(icon: Icons.home_rounded, label: 'HOME'),
    NavItemEntity(icon: Icons.menu_book_outlined, label: 'LIBRARY'),
    NavItemEntity(icon: Icons.bookmark_border_rounded, label: 'WISHLIST'),
    NavItemEntity(icon: Icons.storefront_outlined, label: 'SHOP'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.bottomNavHeight,
      decoration: BoxDecoration(
        color: AppColors.navBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final active = i == _selected;
          return GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _items[i].icon as IconData,
                  color: active
                      ? AppColors.navActive
                      : AppColors.navInactive,
                  size: 22,
                ),
                const SizedBox(height: 4),
                Text(
                  _items[i].label,
                  style: AppTextStyles.navLabel.copyWith(
                    color: active
                        ? AppColors.navActive
                        : AppColors.navInactive,
                    fontWeight: active
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
