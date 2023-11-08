import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetNumberTrivia extends Mock implements GetNumberTrivia {
  @override
  Future<Either<Failure, NumberTrivia>?> call(Params params) =>
      super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: Future<Either<Failure, NumberTrivia>?>.value(),
        returnValueForMissingStub:
            Future<Either<Failure, NumberTrivia>?>.value(),
      );
}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTriva {}

class FakeEither<L, R> extends Fake implements Either<L, R> {}

class MockInputConverter extends Mock implements InputConverter {
  @override
  Either<Failure, int> stringToInt(String str) => super.noSuchMethod(
        Invocation.method(
          #stringToInt,
          [str],
        ),
        returnValue: FakeEither<Failure, int>(),
        returnValueForMissingStub: FakeEither<Failure, int>(),
      );
}

void main() {
  late MockGetNumberTrivia mockGetNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumberTriviaBloc bloc;

  setUp(() {
    mockGetNumberTrivia = MockGetNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      getNumberTrivia: mockGetNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('intial state should be empty', () {
    expect(bloc.initialState, equals(Empty()));
  });
  group('GetTriviaForNumber', () {
    final tNumberString = '1';
    final tnumberParsed = 1;
    final tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test('should call input converter to convert string to an int', () async {
      when(mockInputConverter.stringToInt(tNumberString)).thenReturn(
        Right(tnumberParsed),
      );
      bloc.add(GetTriviaforNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToInt(tNumberString));
      verify(mockInputConverter.stringToInt(tNumberString));
    });

    test('should emit [Error] when is the input string is invalid', () async {
      when(mockInputConverter.stringToInt(tNumberString))
          .thenReturn(left(InvalidInputFailure()));
      final expected = [
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));

      bloc.add(GetTriviaforNumber(tNumberString));
    });

    test('should get data from gettrivia usescase', () async {
      when(mockInputConverter.stringToInt(tNumberString)).thenReturn(
        Right(tnumberParsed),
      );
      when(mockGetNumberTrivia(Params(number: tnumberParsed)))
          .thenAnswer((_) async => Right(tNumberTrivia));
      bloc.add(GetTriviaforNumber(tNumberString));
      await untilCalled(mockGetNumberTrivia(Params(number: tnumberParsed)));
      verify(mockGetNumberTrivia(Params(number: tnumberParsed)));
    });

    test('should emit [loading, loaded] when data is gotten succefully',
        () async {
      when(mockInputConverter.stringToInt(tNumberString)).thenReturn(
        Right(tnumberParsed),
      );
      when(mockGetNumberTrivia(Params(number: tnumberParsed)))
          .thenAnswer((_) async => Right(tNumberTrivia));
      final expected = [
        Empty(),
        Loading(),
        Loaded(tiriva: tNumberTrivia),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.add(GetTriviaforNumber(tNumberString));
    });

    test('should emit [loading, Error] when getting data fails', () async {
      when(mockInputConverter.stringToInt(tNumberString)).thenReturn(
        Right(tnumberParsed),
      );
      when(mockGetNumberTrivia(Params(number: tnumberParsed)))
          .thenAnswer((_) async => left(ServerFaliure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.add(GetTriviaforNumber(tNumberString));
    });

    test('should emit [loading, Error] when getting data fails', () async {
      when(mockInputConverter.stringToInt(tNumberString)).thenReturn(
        Left(CacheFaliure()),
      );
      when(mockGetNumberTrivia(Params(number: tnumberParsed)))
          .thenAnswer((_) async => left(CacheFaliure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.add(GetTriviaforNumber(tNumberString));
    });
  });

  //random
  group('GetRandomNumberTrivia', () {
    final tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);
    test('should get data from random usescase', () async {
      when(mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => Right(tNumberTrivia));
      bloc.add(EGetRandomNumberTrivia());
      await untilCalled(mockGetRandomNumberTrivia(NoParams()));
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [loading, loaded] when data is gotten succefully',
        () async {
      when(mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => Right(tNumberTrivia));
      final expected = [
        Empty(),
        Loading(),
        Loaded(tiriva: tNumberTrivia),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.add(EGetRandomNumberTrivia());
    });

    test('should emit [loading, Error] when getting data fails', () async {
      when(mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => left(ServerFaliure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.add(EGetRandomNumberTrivia());
    });

    test('should emit [loading, Error] when getting data fails', () async {
      when( mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => left(CacheFaliure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      bloc.add(EGetRandomNumberTrivia());
    });
  });
}
