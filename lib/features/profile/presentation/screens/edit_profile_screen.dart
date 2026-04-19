import 'package:flutter/material.dart';
import 'package:readify_app/features/profile/presentation/widgets/edit_field.dart';
import 'package:readify_app/features/profile/presentation/widgets/profile_pic.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ProfilePic(onEdit: () {
              // Logic to pick image from gallery
            }),
            const SizedBox(height: 40),
            
            // Input Fields
            const EditField(label: "Full Name", hint: "John Doe"),
            const EditField(label: "Email", hint: "johndoe@example.com", keyboardType: TextInputType.emailAddress),
            const EditField(label: "Phone Number", hint: "+1 234 567 890", keyboardType: TextInputType.phone),
            const EditField(label: "Address", hint: "New York, USA"),
            
            const SizedBox(height: 40),
            
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A65),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                onPressed: () {
                  // Save logic here
                  Navigator.pop(context);
                },
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}