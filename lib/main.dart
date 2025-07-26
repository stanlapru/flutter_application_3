import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/pages/main/first_page.dart';
import 'package:flutter_application_2/pages/main/second_page.dart';
import 'package:flutter_application_2/pages/auth/sign_in_page.dart';
import 'package:flutter_application_2/pages/main/third_page.dart';
import 'package:flutter_application_2/services/auth_service.dart';
import 'package:flutter_application_2/widgets/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
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

  void _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (isDesktop && constraints.maxWidth > 600) {
                // Desktop
                return Scaffold(
                  appBar: AppBar(
                    title: Text(user?.email ?? ""),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.exit_to_app_rounded),
                        onPressed: () async {
                          await AuthService.signOut();
                        },
                      ),
                    ],
                  ),
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
                      const VerticalDivider(thickness: 1, width: 1),
                      TextButton(
                        onPressed: () async {
                          _launchUrl(Uri.parse('https://google.com'));
                        },
                        child: Text('Кнопка'),
                      ),
                      Expanded(child: _pages[_current_screen]),
                    ],
                  ),
                );
              } else {
                // Mobile
                return Scaffold(
                  appBar: AppBar(
                    title: Text(user?.email ?? ""),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.exit_to_app_rounded),
                        onPressed: () async {
                          await AuthService.signOut();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline_rounded),
                        onPressed: () async {
                          showDialogInfo(context, "Информация", "Привет всем");
                        },
                      ),
                    ],
                  ),
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
        } else {
          return SignInPage();
        }
      },
    );
  }
}
