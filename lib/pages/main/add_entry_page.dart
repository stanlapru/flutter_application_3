import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/auth_service.dart';
import 'package:flutter_application_2/services/firestore_service.dart';
import 'package:flutter_application_2/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({super.key});

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _linkController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_titleController.text.isEmpty || _summaryController.text.isEmpty || _bodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Поля не должны быть пустыми')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirestoreService.addNews({
        'title': _titleController.text,
        'summary': _summaryController.text,
        'body': _bodyController.text,
        'link': _linkController.text,
        'createdAt': FieldValue.serverTimestamp(),
        'userId': AuthService.currentUser?.uid,
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Опубликовать')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Заголовок')),
            TextField(controller: _summaryController, decoration: const InputDecoration(labelText: 'Описание')),
            TextField(controller: _linkController, decoration: const InputDecoration(labelText: 'Ссылка на картинку')),
            TextField(controller: _bodyController, decoration: const InputDecoration(labelText: 'Полное содержание'), maxLines: 10),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _submit, child: const Text('Опубликовать')),
          ],
        ),
      ),
    );
  }
}
