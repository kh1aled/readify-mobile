import 'package:flutter/material.dart';
import 'package:readify_app/core/services/service_locator.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/profile/profile_image_notifier.dart';

/// A search bar with a live-updating profile avatar.
///
/// The avatar automatically reflects image changes made on the Profile screen
/// via [profileImageNotifier] — no rebuild of the parent required.
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  void initState() {
    super.initState();

    // Seed the notifier from SharedPreferences on first load if not yet set.
    // This ensures the avatar is correct right after a cold start.
    if (profileImageNotifier.value == null) {
      final cached = sl<TokenStorageService>().getUserImage();
      if (cached != null && cached.isNotEmpty) {
        profileImageNotifier.value = cached;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          // ── Live avatar — rebuilds whenever profileImageNotifier changes ──
          ValueListenableBuilder<String?>(
            valueListenable: profileImageNotifier,
            builder: (context, imageUrl, _) {
              return _avatar(context, imageUrl);
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _avatar(BuildContext context, String? imageUrl) => ClipOval(
        child: InkWell(
          onTap: () =>
              Navigator.pushReplacementNamed(context, '/profile'),
          child: imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  // Use a unique key so Flutter replaces the widget when the
                  // URL changes (avoids the image cache serving the old image)
                  key: ValueKey(imageUrl),
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
