import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failure.dart';
import '../entities/number_trivia.dart';
import '../repo/number_trivia_repo.dart';

class GetNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepo repo;

  GetNumberTrivia(this.repo);

 @override
  Future<Either<Failure, NumberTrivia>?> call(Params params) async{
    return await repo.getNumberTrivia(params.number);
    
  }
}

class Params extends Equatable {
  final int number;
  Params({required this.number});

  @override
  List<Object> get props => [number];
}
