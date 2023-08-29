import 'package:flutter/material.dart';
import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.settings_rounded,
    name: 'settings',
    child: SettingsPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        child: Text('pop'),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
