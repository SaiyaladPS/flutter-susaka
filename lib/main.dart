import 'package:flutter/material.dart';
import 'package:flutter_basess/app_settings.dart';
import 'package:flutter_basess/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppSettings.darkMode,
      builder: (context, isDarkMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Routing',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.orange,
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF12151A),
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routes: AppRouter.routes,
          home: const MainMenuPage(),
        );
      },
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  static const List<_MenuGroup> _menuGroups = [
    _MenuGroup(
      title: 'ກຸ່ມຈັດການຂໍ້ມູນ',
      subtitle: 'Data Management',
      items: [
        _MenuItem(
          title: 'ໄປໜ້າ CRUD',
          subtitle: 'Create, Read, Update, Delete',
          routeName: AppRouter.crud,
          color: Colors.orange,
          icon: Icons.edit_note_rounded,
        ),
      ],
    ),
    _MenuGroup(
      title: 'ກຸ່ມທົດລອງ UI ແລະ State',
      subtitle: 'UI & State Demo',
      items: [
        _MenuItem(
          title: 'ໄປໜ້າ Change BG',
          subtitle: 'Background color demo',
          routeName: AppRouter.changeBg,
          color: Colors.blue,
          icon: Icons.format_paint_rounded,
        ),
        _MenuItem(
          title: 'ໄປໜ້າ Count',
          subtitle: 'Counter state demo',
          routeName: AppRouter.count,
          color: Colors.green,
          icon: Icons.exposure_plus_1_rounded,
        ),
        _MenuItem(
          title: 'ລາຍການໂທ',
          subtitle: 'Call Phone',
          routeName: AppRouter.call,
          color: Colors.orange,
          icon: Icons.call,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(""),
            const Text(
              'ເມນູຫຼັກ (Main Menu)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Noto Sans Lao',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.setting);
              },
              label: Icon(Icons.settings),
              style: ButtonStyle(backgroundColor: null),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _menuGroups.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final group = _menuGroups[index];
          return _MenuGroupCard(group: group);
        },
      ),
    );
  }
}

class _MenuGroupCard extends StatelessWidget {
  const _MenuGroupCard({required this.group});

  final _MenuGroup group;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Noto Sans Lao',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              group.subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            ...group.items.map((item) => _MenuTile(item: item)),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.item});

  final _MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: item.color,
          child: Icon(item.icon, color: Colors.white),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        subtitle: Text(item.subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () => Navigator.pushNamed(context, item.routeName),
      ),
    );
  }
}

class _MenuGroup {
  const _MenuGroup({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  final String title;
  final String subtitle;
  final List<_MenuItem> items;
}

class _MenuItem {
  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.routeName,
    required this.color,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String routeName;
  final Color color;
  final IconData icon;
}
