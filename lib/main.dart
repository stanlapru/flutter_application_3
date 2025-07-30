import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/pages/detail_page.dart';
import 'package:flutter_application_2/pages/main/first_page.dart';
import 'package:flutter_application_2/pages/main/second_page.dart';
import 'package:flutter_application_2/pages/auth/sign_in_page.dart';
import 'package:flutter_application_2/pages/main/third_page.dart';
import 'package:flutter_application_2/pages/settings_page.dart';
import 'package:flutter_application_2/services/auth_service.dart';
import 'package:flutter_application_2/theme/color_schemes.dart';
import 'package:flutter_application_2/theme/theme_notifier.dart';
import 'package:flutter_application_2/widgets/dialogs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializePreferences();
  final theme = await getTheme();
  print(theme);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => ThemeNotifier(
                lightTheme: createLightColorData(),
                darkTheme: createDarkColorData(),
                initialTheme: theme,
              ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> initializePreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

  if (isFirstLaunch) {
    print('this is first launch!');
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    await prefs.setString(
      'theme',
      brightness == Brightness.dark ? 'dark' : 'light',
    );
    print('set brightness to ${prefs.getString('theme')}');
    await prefs.setBool('firstLaunch', false);
  }
}

Future<String> getTheme() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? theme = prefs.getString('theme') ?? 'dark';
  print('got theme: $theme');
  return theme;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    print('current thememode: ${themeNotifier.themeMode}');

    return MaterialApp(
      title: 'Занятие 7',
      theme: themeNotifier.lightTheme,
      darkTheme: themeNotifier.darkTheme,
      themeMode: themeNotifier.themeMode,
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
    const SettingsPage(),
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
                            icon: Icon(Icons.feed_rounded),
                            label: Text("Лента"),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.looks_two_rounded),
                            label: Text("Второй"),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.settings),
                            label: Text("Настройки"),
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
                  drawer: Drawer(
                    child: ListView(
                      children: [
                        DrawerHeader(child: Text('Приложение')),
                        Image.asset(
                          'assets/image1.jpg',
                          height: 100,
                          fit: BoxFit.contain
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('Info'),
                          onTap: () {
                            showDialogInfo(
                              context,
                              "Информация",
                              "Привет всем",
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.newspaper),
                          title: Text('Новость'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => DetailPage(
                                      title: 'title',
                                      text: 'text',
                                      text2: 'text2',
                                      color: Colors.amber,
                                    ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  body: _pages[_current_screen],
                  bottomNavigationBar: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.feed),
                        label: "Лента",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.looks_two_rounded),
                        label: "Второй",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: "Настройки",
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
