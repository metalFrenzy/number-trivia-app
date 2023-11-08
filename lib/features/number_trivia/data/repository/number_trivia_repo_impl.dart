import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repo/number_trivia_repo.dart';
import '../sources/number_trivia_local_source.dart';
import '../sources/number_trivia_remote_source.dart';
import '../../../../core/errors/expections.dart';

class NumberTriviaRepoImpl implements NumberTriviaRepo {
  final NumberTriviaRemoteSource remote;
  final NumberTriviaLocalSource local;
  final NetworkInfo networkInfo;

  NumberTriviaRepoImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int number) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remote.getNumberTrivia(number)!;
        local.cachNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return left(ServerFaliure());
      }
    } else {
      try {
        final localTrivia = await local.getLastNumberTrivia();
        return right(localTrivia!);
      } on CacheExpection {
        return left(CacheFaliure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia()async {
     if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remote.getRandomNumberTrivia();
        local.cachNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return left(ServerFaliure());
      }
    } else {
      try {
        final localTrivia = await local.getLastNumberTrivia();
        return right(localTrivia!);
      } on CacheExpection {
        return left(CacheFaliure());
      }
    }
  }
}
