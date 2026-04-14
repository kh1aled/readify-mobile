import 'package:flutter/material.dart';

class LibrarySortRow extends StatelessWidget {
  const LibrarySortRow({super.key, this.label = 'RECENT'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.sort_rounded, size: 16, color: Colors.grey.shade500),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}