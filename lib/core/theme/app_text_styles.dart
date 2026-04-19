import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle titleLarge = TextStyle(
    color: AppColors.textDark,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle titleMedium = TextStyle(
    color: AppColors.textDark,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle subtitle = TextStyle(
    color: AppColors.textMid,
    fontSize: 14,
  );

  static const TextStyle caption = TextStyle(
    color: AppColors.textLight,
    fontSize: 12,
  );

  static const TextStyle bodyMedium = TextStyle(
    color: AppColors.textMid,
    fontSize: 13,
    height: 1.7,
  );

  static const TextStyle statValue = TextStyle(
    color: AppColors.textDark,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle statLabel = TextStyle(
    color: AppColors.textLight,
    fontSize: 11,
  );

  static const TextStyle priceLarge = TextStyle(
    color: AppColors.teal,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle priceSmall = TextStyle(
    color: AppColors.teal,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle priceStrike = TextStyle(
    color: AppColors.textLight,
    fontSize: 11,
    decoration: TextDecoration.lineThrough,
  );

  static const TextStyle navLabel = TextStyle(
    fontSize: 9,
    letterSpacing: 0.5,
  );

  static const TextStyle seeAll = TextStyle(
    color: AppColors.teal,
    fontSize: 12,
  );

  static const TextStyle reviewName = TextStyle(
    color: AppColors.textDark,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle reviewBody = TextStyle(
    color: AppColors.textMid,
    fontSize: 13,
    height: 1.6,
  );
}
