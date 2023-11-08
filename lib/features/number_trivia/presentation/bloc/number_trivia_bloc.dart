import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/usecases/usecase.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetNumberTrivia getNumberTrivia;
  final GetRandomNumberTriva getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaState get initialState => Empty();

  NumberTriviaBloc({
    required this.getNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaforNumber>((event, emit) async {
      final inputEither = inputConverter.stringToInt(event.numberString);
      await inputEither.fold((faliure) {
        emit(
          Error(
            message: INVALID_INPUT_FAILURE_MESSAGE,
          ),
        );
      }, (integer) async {
        print(integer);
        emit(Loading());
        final failureOrTrivia = await getNumberTrivia(Params(number: integer));
        failureOrTrivia!.fold((failure) {
          emit(
            Error(
              message: _mapFailureToMessage(failure),
            ),
          );
        }, (trivia) async {
          emit(
            Loaded(tiriva: trivia),
          );
        });
      });
    });
    on<EGetRandomNumberTrivia>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      await failureOrTrivia!.fold((failure) {
        emit(
          Error(
            message: _mapFailureToMessage(failure),
          ),
        );
      }, (trivia) {
        emit(
          Loaded(tiriva: trivia),
        );
      });
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFaliure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFaliure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
