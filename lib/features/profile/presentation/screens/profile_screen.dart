import 'package:flutter/material.dart';
import 'package:readify_app/features/profile/presentation/widgets/profile_menu.dart';
import 'package:readify_app/features/profile/presentation/widgets/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(onEdit: () {}),
            const SizedBox(height: 15),
            // User Info Section
            const Text(
              "John Doe",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "johndoe@example.com",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            // Log Out with a specific color for UX clarity
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              textColor: Colors.redAccent,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
