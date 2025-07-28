import 'dart:convert';

class Entry {
  final String id;
  final String title;
  final String summary;
  final String body;
  final List<String> url;
  final String userId;
  final String createdAt;

  Entry({
    required this.id,
    required this.title,
    required this.summary,
    required this.body,
    required this.url,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'summary': summary,
    'body': body,
    'url': url,
    'userid': userId,
    'date': createdAt,
  };

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
    id: json['id'].toString(),
    title: json['title'] ?? '',
    summary: json['summary'] ?? '',
    body: json['body'] ?? '',
    url: List<String>.from(jsonDecode(json['url']).map((e) => e.toString())),
    userId: json['userId'] ?? '',
    createdAt: json['date'] ?? ''
  );
}
