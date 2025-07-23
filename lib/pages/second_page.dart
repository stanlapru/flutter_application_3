import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вторая страница')),
      body: Center(
        child: Column(
          children: [
            Icon(Icons.restaurant),
            SizedBox(height: 8),
            Text('Это вторая страница!'),
          ],
        ),
      ),
    );
  }
}
