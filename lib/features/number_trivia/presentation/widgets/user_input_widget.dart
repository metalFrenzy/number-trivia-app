import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class UserInput extends StatefulWidget {
  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final _inputStrController = TextEditingController();
  void _getNumberEvent() {
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetTriviaforNumber(_inputStrController.text),
    );
    _inputStrController.clear();
  }

  void _getRandomEvent() async {
    BlocProvider.of<NumberTriviaBloc>(context).add(
      EGetRandomNumberTrivia(),
    );
  }

  @override
  void dispose() {
    _inputStrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 211, 206, 212),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            onSubmitted: (_) {
              _getNumberEvent();
              
            },
            keyboardType: TextInputType.number,
            controller: _inputStrController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter a Postive integer number',
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 115, 114, 116),
                fontSize: 15,
                fontFamily: 'Raleway',
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(160, 40),
              ),
              onPressed: _getNumberEvent,
              child: Text(
                'Search',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(190, 40),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: _getRandomEvent,
              child: Text(
                'Get random trivia',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
