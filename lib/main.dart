import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/first_page.dart';
import 'package:flutter_application_2/pages/second_page.dart';
import 'package:flutter_application_2/pages/third_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Занятие 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 183, 177, 58),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _current_screen = 0;

  final List<Widget> _pages = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_current_screen],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one_rounded),
            label: "Первый",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two_rounded),
            label: "Второй",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.three_g_mobiledata),
            label: "Третий",
          ),
        ],
        currentIndex: _current_screen,
        onTap: (value) {
          setState(() {
            _current_screen = value;
          });
        },
      ),
    );
  }
}
