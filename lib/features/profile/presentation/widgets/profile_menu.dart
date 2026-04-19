import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback? press;
  final Color textColor; // Added to allow red for Log Out

  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
    this.textColor = const Color(0xFF424242), // Darker for better readability
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              colorFilter: ColorFilter.mode(
                textColor == Colors.redAccent ? Colors.redAccent : const Color(0xFFFF7643), 
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFFBDBDBD),
            ),
          ],
        ),
      ),
    );
  }
}