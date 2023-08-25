import 'package:bloc_to_do_app/2_application/app/pages/components/detail/detail_page.dart';
import 'package:bloc_to_do_app/2_application/app/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:bloc_to_do_app/2_application/app/pages/dashboard/dashboard_page.dart';
import 'package:bloc_to_do_app/2_application/app/pages/home/bloc/navigation_cubit.dart';
import 'package:bloc_to_do_app/2_application/app/pages/overview/overview_page.dart';
import 'package:bloc_to_do_app/2_application/app/pages/settings/settings_page.dart';
import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }) : index = tabs.indexWhere((element) => element.name == tab);

  final int index;

  static const pageConfig = PageConfig(
    icon: Icons.dashboard_customize_rounded,
    name: 'home',
  );

  // list of all tabs that should be displayed inside our navigation bar
  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map(
        (page) => NavigationDestination(icon: Icon(page.icon), label: page.name),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('primary-navigation-medium'),
                builder: (context) => AdaptiveScaffold.standardNavigationRail(
                  leading: ElevatedButton.icon(
                    key: const Key('create_todo_collection_home'),
                    onPressed: () {
                      context.pushNamed(CreateToDoCollectionPage.pageConfig.name);
                    },
                    label: const Text(''),
                    icon: Icon(CreateToDoCollectionPage.pageConfig.icon),
                  ),
                  trailing: IconButton(
                    onPressed: () => context.goNamed(SettingsPage.pageConfig.name),
                    icon: Icon(SettingsPage.pageConfig.icon),
                  ),
                  selectedLabelTextStyle: TextStyle(color: theme.colorScheme.onBackground),
                  selectedIconTheme: IconThemeData(color: theme.colorScheme.onBackground),
                  unselectedIconTheme: IconThemeData(color: theme.colorScheme.onBackground.withOpacity(0.5)),
                  onDestinationSelected: (index) => _tapOnNavigationDestination(context, index),
                  selectedIndex: widget.index,
                  destinations: destinations
                      .map(
                        (_) => AdaptiveScaffold.toRailDestination(_),
                      )
                      .toList(),
                ),
              ),
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('bottom-navigation-small'),
                builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                  destinations: destinations,
                  currentIndex: widget.index,
                  onDestinationSelected: (value) => _tapOnNavigationDestination(context, value),
                ),
              ),
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('primary-body-small'),
                builder: (_) => HomePage.tabs[widget.index].child,
              ),
            },
          ),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('secondary-body-medium'),
                builder: widget.index != 1
                    ? null
                    : (_) => BlocBuilder<NavigationCubit, NavigationCubitState>(
                          builder: (context, state) {
                            final data = state.selectedCollectionId;
                            final isSecondBodyDisplayed = Breakpoints.mediumAndUp.isActive(context);

                            context.read<NavigationCubit>().secondBodyHasChanged(
                                  isSecondBodyDisplayed: isSecondBodyDisplayed,
                                );

                            if (data == null) {
                              return Container();
                            }
                            return ToDoDetailPageProvider(
                              key: Key(data.value),
                              collectionId: state.selectedCollectionId!,
                            );
                          },
                        ),
              ),
            },
          ),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) => context.goNamed(
        HomePage.pageConfig.name,
        pathParameters: {
          'tab': HomePage.tabs[index].name,
        },
      );
}
