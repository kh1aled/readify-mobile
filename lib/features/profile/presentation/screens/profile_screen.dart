import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readify_app/core/services/service_locator.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/profile/data/profile_remote_data_source.dart';
import 'package:readify_app/features/profile/domain/profile_model.dart';
import 'package:readify_app/features/profile/presentation/widgets/profile_menu.dart';
import 'package:readify_app/features/profile/presentation/widgets/profile_pic.dart';
import 'package:readify_app/features/profile/profile_image_notifier.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _tokenStorage = sl<TokenStorageService>();

  late final ProfileRemoteDataSource _dataSource = ProfileRemoteDataSource(
    tokenStorage: _tokenStorage,
  );

  late Future<ProfileModel> _profileFuture;

  // Tracks the locally-updated image URL (overrides server value after upload)
  String? _profileImageUrl;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _profileFuture = _dataSource.getProfile();

    // Initialize with the cached image so the UI is instant on first load
    _profileImageUrl = _tokenStorage.getUserImage();
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked == null) return;

    setState(() => _uploading = true);

    try {
      String newUrl;

      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        newUrl = await _dataSource.uploadProfileImageBytes(bytes, picked.name);
      } else {
        newUrl = await _dataSource.uploadProfileImage(File(picked.path));
      }

      // 1. Persist to SharedPreferences so the token service has it
      await _tokenStorage.saveImage(newUrl);

      // 2. Notify all listeners (SearchBarWidget, etc.) of the new URL
      profileImageNotifier.value = newUrl;

      // 3. Update local state
      setState(() => _profileImageUrl = newUrl);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _tokenStorage.clear();

    // Reset the notifier on logout
    profileImageNotifier.value = null;

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/layout'),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<ProfileModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _profileFuture = _dataSource.getProfile()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final user = snapshot.data!;

          // Prefer the locally updated URL; fall back to server value
          final imageUrl =
              _profileImageUrl ?? user.profileImage;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                // ── Profile Picture ─────────────────────────────────
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ProfilePic(
                      imageUrl: imageUrl,
                      onEdit: _uploading ? null : _pickAndUploadImage,
                    ),
                    if (_uploading)
                      const SizedBox(
                        width: 115,
                        height: 115,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                  ],
                ),

                const SizedBox(height: 16),

                // ── User Info ────────────────────────────────────────
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const SizedBox(height: 28),

                // ── Menu Items ───────────────────────────────────────
                ProfileMenu(
                  text: 'My Account',
                  icon: 'assets/icons/User Icon.svg',
                  press: () {},
                ),

                ProfileMenu(
                  text: 'Log Out',
                  icon: 'assets/icons/Log out.svg',
                  textColor: Colors.redAccent,
                  press: _logout,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
