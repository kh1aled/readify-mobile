import 'package:flutter/material.dart';
import 'dart:html' as html;

class PdfReaderScreen extends StatelessWidget {
  final String url;

  const PdfReaderScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      html.window.open(url, "_blank");
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Reader"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text("PDF opened in a new tab"),
      ),
    );
  }
}