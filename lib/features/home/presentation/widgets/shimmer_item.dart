import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      child: Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 5,
                color: Colors.white,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 40,
                height: 4,
                color: Colors.white,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 150,
                height: 10,
                color: Colors.white,
              ),
            ],
          )),
    );
  }
}
