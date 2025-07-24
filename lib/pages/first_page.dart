import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Первая страница')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FeedCard(title: '123', text: 'abcd', color: Colors.amber),
            FeedCard(title: '12j3', text: 'abcdehthdthhh', color: Colors.greenAccent),
            FeedCard(title: '1jghjhg23', text: 'abcdjghjghjgj', color: const Color.fromARGB(255, 224, 105, 240)),
            FeedCard(title: 'jjgjh', text: 'abchgjhjgjd', color: Colors.greenAccent),
            FeedCard(title: '12jghj3', text: 'abghjghjghjghcd', color: const Color.fromARGB(255, 118, 105, 240)),
            FeedCard(title: '12ghjjhg3', text: 'abcjhjghjghjgjgd', color: Colors.greenAccent),
          ],
        ),
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final Color color;
  final String title;
  final String text;
  const FeedCard({super.key, required this.color,  required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 206, 206, 206),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              color: color,
              height: 200,
            ),
            Text(title, style: TextStyle(fontSize: 28)),
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}
