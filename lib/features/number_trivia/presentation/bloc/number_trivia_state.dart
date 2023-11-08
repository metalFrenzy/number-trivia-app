part of 'number_trivia_bloc.dart';

class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia tiriva;
  Loaded({
    required this.tiriva,
  });
}

class Error extends NumberTriviaState {
  final String message;
  Error({
    required this.message,
  });
}
