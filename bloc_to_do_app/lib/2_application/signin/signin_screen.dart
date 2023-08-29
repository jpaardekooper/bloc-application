import 'package:bloc_to_do_app/2_application/app/bloc/auth_cubit.dart';
import 'package:bloc_to_do_app/2_application/core/page_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.login,
    name: 'signin',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        child: Text('signin'),
        onPressed: () {
          context.read<AuthCubit>().authStateChanged(alo: 'yes');
          context.pop();
        },
      ),
    );
  }
}
