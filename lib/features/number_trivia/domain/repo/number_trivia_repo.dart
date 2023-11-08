import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/number_trivia.dart';

abstract class NumberTriviaRepo {
  Future<Either<Failure,NumberTrivia>>?getNumberTrivia(int number);
  Future<Either<Failure,NumberTrivia>>?getRandomNumberTrivia();
}
