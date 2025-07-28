import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _theme = 'dark';

  final List<String> _themes = ['light', 'dark'];

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = prefs.getString('theme') ?? 'dark';
      print('got theme $_theme');
    });
  }

  void _saveThemePreference(String theme) {
    print('saving theme $_theme');
    _saveToPrefs('theme', theme);
    Provider.of<ThemeNotifier>(context, listen: false).setTheme(theme);
  }

  Future<void> _saveToPrefs(String key, String val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
    print('saved to prefs: $key, ${prefs.getString(key)}');
  }

  void _onThemeChanged(String? value) {
    if (value != null) {
      print('value on theme changed $value');
      setState(() {
        _theme = value;
      });
      _saveThemePreference(value);
    }
  }

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: Center(
        child: Column(
          children: [
            Text('Настройка темы'),
            Divider(),
            _buildDropdown(
              context: context,
              value: _theme,
              items: _themes,
              onChanged: _onThemeChanged,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required bool isDarkMode,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 60,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: value,
          isExpanded: true,
          items:
              items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
