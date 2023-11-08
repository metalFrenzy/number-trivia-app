import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repo/number_trivia_repo.dart';

class GetRandomNumberTriva implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepo repo;

  GetRandomNumberTriva(this.repo);

  @override
  Future<Either<Failure, NumberTrivia>?> call(NoParams params) async {
    return await repo.getRandomNumberTrivia();
  }
}
