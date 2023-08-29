import 'package:bloc_to_do_app/0_data/data_sources/local/hive_local_data_source.dart';
import 'package:bloc_to_do_app/0_data/repositories/todo_repository_local.dart';
import 'package:bloc_to_do_app/2_application/app/bloc/auth_cubit.dart';
import 'package:bloc_to_do_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_to_do_app/1_domain/repositories/todo_repository.dart';
import 'package:bloc_to_do_app/2_application/app/basic_app.dart';
import 'package:go_router/go_router.dart';

late final FirebaseApp app;

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;

  WidgetsFlutterBinding.ensureInitialized();
  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391

  // We store the app and auth to make testing with a named instance easier.
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthCubit authCubit = AuthCubit();

  final localDataSource = HiveLocalDataSource();
  await localDataSource.init();
  runApp(MultiBlocProvider(
    providers: [
      RepositoryProvider<ToDoRepository>(
        create: (context) => ToDoRepositoryLocal(
          localDataSource: localDataSource,
        ),
      ),
      BlocProvider<AuthCubit>(
        create: (context) => authCubit,
      )
    ],
    child: const BasicApp(),
  )

      // RepositoryProvider<ToDoRepository>(
      //   create: (context) => ToDoRepositoryLocal(
      //     localDataSource: localDataSource,
      //   ),
      //   child: ,
      // ),
      );
}
