import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ToDoDetailLoading extends StatelessWidget {
  const ToDoDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.yellow,
      period: Duration(milliseconds: 100),
      child: Text('loading'),
    );
  }
}
