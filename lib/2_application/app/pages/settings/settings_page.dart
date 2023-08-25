import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.search_off_rounded,
    name: 'settings',
    child: SettingsPage(),
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
