import 'package:bloc_to_do_app/1_domain/entities/todo_collection.dart';
import 'package:bloc_to_do_app/2_application/app/pages/components/detail/detail_page.dart';
import 'package:bloc_to_do_app/2_application/app/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:bloc_to_do_app/2_application/app/pages/home/bloc/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ToDoOverviewLoaded extends StatelessWidget {
  const ToDoOverviewLoaded({
    super.key,
    required this.collections,
  });

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(CreateToDoCollectionPage.pageConfig.name),
        child: Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          final colorScheme = Theme.of(context).colorScheme;

          return BlocBuilder<NavigationCubit, NavigationCubitState>(
            buildWhen: (previous, current) => previous.selectedCollectionId != current.selectedCollectionId,
            builder: (context, state) {
              return ListTile(
                tileColor: colorScheme.surface,
                selectedTileColor: colorScheme.surfaceVariant,
                iconColor: item.color.color,
                selectedColor: item.color.color,
                selected: state.selectedCollectionId == item.id,
                onTap: () {
                  context.read<NavigationCubit>().selectedToDoCollectionChanged(item.id);

                  if (Breakpoints.small.isActive(context)) {
                    context.pushNamed(
                      ToDoDetailPage.pageConfig.name,
                      pathParameters: {'collectionId': item.id.value},
                    );
                  }
                },
                leading: const Icon(Icons.circle),
                title: Text(item.title),
              );
            },
          );
        },
      ),
    );
  }
}
