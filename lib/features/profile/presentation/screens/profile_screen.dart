import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/core/services/service_locator.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/profile/data/profile_remote_data_source.dart';
import 'package:readify_app/features/profile/domain/profile_model.dart';
import 'package:readify_app/features/profile/presentation/widgets/profile_menu.dart';
import 'package:readify_app/features/profile/presentation/widgets/profile_pic.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final tokenStorageService = sl<TokenStorageService>();

  late final ProfileRemoteDataSource dataSource = ProfileRemoteDataSource(
    tokenStorage: sl<TokenStorageService>(),
  );

  late final Future<ProfileModel> profileFuture = dataSource.getProfile();

  // tracks the current image URL
  String? _profileImageUrl;
  bool _uploading = false;

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
        // Web: read bytes directly from XFile
        final bytes = await picked.readAsBytes();
        newUrl = await dataSource.uploadProfileImageBytes(bytes, picked.name);
      } else {
        // Mobile: use File path
        newUrl = await dataSource.uploadProfileImage(File(picked.path));
      }

      setState(() => _profileImageUrl = newUrl);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Upload failed: $e")));
      }
    } finally {
      setState(() => _uploading = false);
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
          onPressed: () => Navigator.pushReplacementNamed(context, "/layout"),
          icon: const Icon(Icons.arrow_back_ios),
          alignment: Alignment.center,
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<ProfileModel>(
        future: profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final user = snapshot.data!;

          // Use picked/uploaded URL if available, else the user's stored one
          final imageUrl =
              _profileImageUrl ??
              (user.profileImage != null
                  ? "${user.profileImage}"
                  : null);

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ProfilePic(
                      imageUrl: imageUrl,
                      onEdit: _uploading ? null : _pickAndUploadImage,
                    ),
                    if (_uploading)
                      const CircularProgressIndicator(), // overlay spinner
                  ],
                ),

                const SizedBox(height: 15),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(user.email, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 25),

                ProfileMenu(
                  text: "My Account",
                  icon: "assets/icons/User Icon.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  textColor: Colors.redAccent,
                  press: () async {
                    await tokenStorageService.clear();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/login",
                        (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
