import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repo/number_trivia_repo.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepo extends Mock implements NumberTriviaRepo {}

void main() {
  late GetRandomNumberTriva usescase;
  late MockNumberTriviaRepo mockNumberTriviaRepo;
  late NumberTrivia tNumberTrivia;
  setUp(() {
    mockNumberTriviaRepo = MockNumberTriviaRepo();
    usescase = GetRandomNumberTriva(mockNumberTriviaRepo);
    tNumberTrivia = NumberTrivia(text: 'zeby', number: 1);
  });

  test(
    'should get trivia from repo',
    () async {
      when(mockNumberTriviaRepo.getRandomNumberTrivia()).thenAnswer((_) async {
        return Right(tNumberTrivia);
      });
      final result = await usescase(NoParams());

      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepo.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepo);
    },
  );
}
