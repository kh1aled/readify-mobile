import 'package:flutter/material.dart';

class BookTopBar extends StatelessWidget {
  const BookTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
        ),
      ),
    );

  }
}
