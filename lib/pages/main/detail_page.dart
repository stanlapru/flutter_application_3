import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String text;
  final String text2;
  const DetailPage({
    super.key,
    required this.title,
    required this.text,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 28)),
            Text(text),
            Text(text2),
          ],
        ),
      ),
    );
  }
}
