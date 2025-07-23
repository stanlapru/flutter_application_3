// widget.dart
import 'package:flutter/material.dart';

class GreatText extends StatefulWidget {
  @override
  _GreatTextState createState() => _GreatTextState();
}

class _GreatTextState extends State<GreatText> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 11),
            child: Text(
              'Счетчик: $_counter\nСтолько раз вы нажали на кнопку1111111111111111111111111111111111111111111111111111111',
              style: TextStyle(color: Colors.purple),
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Прибавить 1'),
          ),
        ],
      ),
    );
  }
}
