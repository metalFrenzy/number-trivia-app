import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  TriviaDisplay({required this.numberTrivia});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            Text(
              numberTrivia.number.toString(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              numberTrivia.text,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
