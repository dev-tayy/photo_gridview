import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextLoadingView extends StatelessWidget {
  const TextLoadingView({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text ?? 'Please wait...',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: const CupertinoActivityIndicator(),
          )
        ],
      ),
    );
  }
}
