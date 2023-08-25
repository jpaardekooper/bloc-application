import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.dashboard_customize_rounded,
    name: 'dashboard',
    child: DashboardPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
    );
  }
}
