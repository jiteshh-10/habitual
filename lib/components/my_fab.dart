import 'package:flutter/material.dart';

class MyFloatinfActionButton extends StatelessWidget {
  final Function()? onPressed;

  const MyFloatinfActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
