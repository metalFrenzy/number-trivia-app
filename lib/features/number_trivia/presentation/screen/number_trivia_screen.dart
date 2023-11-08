import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/no_trivia.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/trivia_display.dart';
import '../widgets/user_input_widget.dart';

class NumberTriviaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Number Trivia App',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => sl<NumberTriviaBloc>(),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      if (state is Empty) {
                        return NoTrivia();
                      } else if (state is Loading) {
                        return LoadingWidget();
                      } else if (state is Loaded) {
                        return TriviaDisplay(numberTrivia: state.tiriva);
                      } else if (state is Error) {
                        return MessageDisplay(message: state.message);
                      }
                      return Text('something went wrong');
                    },
                  ),
                  //user input
                  const SizedBox(
                    height: 20,
                  ),
                  UserInput(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
