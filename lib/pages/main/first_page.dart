import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/main/add_entry_page.dart';
import 'package:flutter_application_2/pages/main/detail_page.dart';
import 'package:flutter_application_2/services/firestore_service.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Первая страница')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AddEntryPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService.getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('Error loading news.'));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return FeedCard(
                date: (data['createdAt'] as Timestamp).toDate().toString(),
                title: data['title'],
                text: data['summary'],
                text2: data['body'],
              );
            },
          );
        },
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final String title;
  final String text;
  final String date;
  final String text2;

  const FeedCard({
    super.key,
    required this.title,
    required this.text,
    required this.date,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 206, 206, 206),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => DetailPage(
              title: title,
              text: text,
              text2: text2,
            ),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 28)),
              Divider(),
              Text(date, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(128)),),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
