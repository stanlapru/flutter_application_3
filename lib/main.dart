import 'package:flutter/foundation.dart';
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
          seedColor: const Color.fromARGB(255, 9, 255, 0),
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

  bool get isDesktop =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktop && constraints.maxWidth > 600) {
          // Desktop
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.looks_one_rounded),
                      label: Text("Первый"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.looks_two_rounded),
                      label: Text("Второй"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.three_g_mobiledata),
                      label: Text("Третий"),
                    ),
                  ],
                  labelType: NavigationRailLabelType.all,
                  selectedIndex: _current_screen,
                  onDestinationSelected: (value) {
                    setState(() {
                      _current_screen = value;
                    });
                  },
                ),
                const VerticalDivider(thickness: 1, width: 1,),
                Expanded(child: _pages[_current_screen],)
              ],
            ),
          );
        } else {
          // Mobile
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
      },
    );
  }
}
