import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repo/number_trivia_repo.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_number_trivia.dart';

class MockNumberTriviaRepo extends Mock implements NumberTriviaRepo {}

void main() {
  late GetNumberTrivia usescase;
  late MockNumberTriviaRepo mockNumberTriviaRepo;
  late int tNumber;
  late NumberTrivia tNumberTrivia;
  setUp(() {
    mockNumberTriviaRepo = MockNumberTriviaRepo();
    usescase = GetNumberTrivia(mockNumberTriviaRepo);
    tNumber = 1;
    tNumberTrivia = NumberTrivia(text: 'zeby', number: 1);
  });

  test(
    'should get trivia for number from repo',
    () async {
      
      when(mockNumberTriviaRepo.getNumberTrivia(tNumber)).thenAnswer((_) async {
        return  Right(tNumberTrivia);
      });
      final result = await usescase(Params(number: tNumber));

      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepo.getNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepo);
    },
  );
}
