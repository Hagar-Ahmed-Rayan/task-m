import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key, required this.title, this.height});

  final String title;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.do_not_disturb,
            size: 50,
            color: Colors.red,
          ),
          Text(title),
        ],
      ),
    );
  }
}
