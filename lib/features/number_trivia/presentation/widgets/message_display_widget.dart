import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      child: Text(
        message,
        style: Theme.of(context).textTheme.displayMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
