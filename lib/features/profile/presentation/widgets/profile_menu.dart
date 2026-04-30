import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback? press;
  final Color textColor;

  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
    this.textColor = const Color(0xFF424242),
  });

  @override
  Widget build(BuildContext context) {
    final isDestructive = textColor == Colors.redAccent;
    final iconColor = isDestructive ? Colors.redAccent : const Color(0xFF2D6A65);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Material(
        color: const Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 22,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
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
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
