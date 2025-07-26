import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/firestore_service.dart';
import 'package:share_plus/share_plus.dart';

class NewsBottomSheet extends StatefulWidget {
  final String id;
  final String text;

  const NewsBottomSheet({super.key, required this.id, required this.text});

  @override
  State<StatefulWidget> createState() => _NewsBottomSheetState();
}

class _NewsBottomSheetState extends State<NewsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder:
          (BuildContext context, ScrollController controller) => Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: ListView(
              controller: controller,
              children: [
                Text(
                  'Опции',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    try {
                      FirestoreService.deleteNews(widget.id);
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Не удалось удалить новость'),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.delete_forever_rounded),
                  label: Text('Удалить'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    try {
                      Share.share(widget.text);
                      // SharePlus.instance.share(ShareParams(text: widget.text));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Не удалось поделиться новостью'),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.share),
                  label: Text('Поделиться'),
                ),
              ],
            ),
          ),
    );
  }
}
