import 'package:bloc_to_do_app/1_domain/user_cases/load_todo_collections.dart';
import 'package:bloc_to_do_app/2_application/app/pages/overview/bloc/todo_overview_cubit.dart';
import 'package:bloc_to_do_app/2_application/app/pages/overview/view_state/todo_overview_error.dart';
import 'package:bloc_to_do_app/2_application/app/pages/overview/view_state/todo_overview_loaded.dart';
import 'package:bloc_to_do_app/2_application/app/pages/overview/view_state/todo_overview_loading.dart';
import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewPageProvider extends StatelessWidget {
  const OverviewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoOverviewCubit(
        loadToDoCollections: LoadToDoCollections(
          toDoRepository: RepositoryProvider.of(context),
        ),
      )..readToDoCollections(),
      child: const OverviewPage(),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.work_history_rounded,
    name: 'overview',
    child: OverviewPageProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: BlocBuilder<ToDoOverviewCubit, ToDoOverviewCubitState>(
        builder: (context, state) {
          if (state is ToDoOverviewCubitLoadingState) {
            return const ToDoOverviewLoading();
          } else if (state is ToDoOverviewCubitLoadedState) {
            return ToDoOverviewLoaded(collections: state.collections);
          } else {
            return const ToDoOverviewError();
          }
        },
      ),
    );
  }
}
