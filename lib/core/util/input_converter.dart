import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failure.dart';

class InputConverter {
  Either<Failure, int> stringToInt(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) {
        throw FormatException();
      } else{}
      return right(integer);
    } on FormatException {
      return left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
