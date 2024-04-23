import 'package:flutter/material.dart';

class NoTrivia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/astro.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        const Text(
          ' no Trivia Start adding a number or click the button!',
          style: TextStyle(
            color: Color.fromARGB(255, 43, 42, 43),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
      ],
    );
  }
}
