import 'package:flutter/material.dart';
import 'package:task_manager/features/home/presentation/widgets/shimmer_item.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const ShimmerItem();
        },
      ),
    );
  }
}
