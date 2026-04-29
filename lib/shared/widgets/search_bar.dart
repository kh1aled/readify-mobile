import 'package:flutter/material.dart';
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/core/services/service_locator.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/profile/presentation/screens/profile_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = sl<TokenStorageService>().getUserImage();
    final fullImageUrl = (imageUrl != null && imageUrl.isNotEmpty)
        ? "${imageUrl}"
        : null;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, color: Color(0xFFBFC8C6), size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your books...',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 4),
          _avatar(context, fullImageUrl),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _avatar(BuildContext context, String? imageUrl) => ClipOval(
    child: InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, "/profile"),
      child: imageUrl != null
          ? Image.network(
              imageUrl,
              width: 36,
              height: 36,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(),
            )
          : _placeholder(),
    ),
  );

  Widget _placeholder() => Container(
    width: 36,
    height: 36,
    color: const Color(0xFF2D6A65),
    child: const Icon(Icons.person, color: Colors.white, size: 20),
  );
}
