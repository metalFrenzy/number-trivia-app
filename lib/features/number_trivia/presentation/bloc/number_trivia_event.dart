part of 'number_trivia_bloc.dart';

class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaforNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaforNumber(this.numberString);
  
}

class EGetRandomNumberTrivia extends NumberTriviaEvent {}
