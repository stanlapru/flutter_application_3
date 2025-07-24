import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Color color;
  final String title;
  final String text;
  final String text2;
  const DetailPage({
    super.key,
    required this.color,
    required this.title,
    required this.text,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(color: color, height: 200),
          Text(title, style: TextStyle(fontSize: 28)),
          Text(text),
          Text(text2),
        ],
      ),
    );
  }
}
